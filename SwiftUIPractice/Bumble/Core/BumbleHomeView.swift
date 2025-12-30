//
//  BumbleHomeView.swift
//  SwiftUIPractice
//
//  Created by Emirhan Gökçe on 19.11.2025.
//

import SwiftUI
import SwiftfulUI
import SwiftfulRouting

struct BumbleHomeView: View {
    @Environment(\.router) var router //MARK: Swiftful routing tarafından eklenmis
    
    @State private var filters : [String] = ["Everyone","Trending"]
    @AppStorage("bumble_home_filter") private var selectedFilter = "Everyone"
    @State private var allUsers : [User] = [] //tüm kullanıcı kartlarını tutan dizidir.
    @State private var selectedIndex : Int = 0
    @State private var cardOffsets : [Int:Bool] = [:] //UserId: (Direction is Right == true) ? -> Kaydırılıp atılmış kartların kaybolma pozisyonunu saklamak için kullanılan bir sözlüktür (Dictionary).
        ///int : Kullanıcının benzersiz ID'si (user.id).
        ///Bool: True ise sağa kaydırıldı (Beğenildi), False ise sola kaydırıldı (Reddedildi) anlamına gelir. Bu, kartın ekran dışına doğru animasyonla kaybolması için kullanılır.
    ///
    @State private var currentSwipeOffset : CGFloat = 0
    
    var body: some View {
        ZStack{
            Color.bumbleWhite.ignoresSafeArea()
            VStack(spacing:12){
                header
                
                BumbleFilterView(options: filters, selection: $selectedFilter)
                    .background(
                        Divider()
                        ,alignment: .bottom
                    )
                
//                BumbleCardView()
                
                ZStack{
                    if !allUsers.isEmpty{
                        //TODO: Bu kısmı anlamadim
                        ///allUsers.enumerated(): Bu, bir diziyi döndürür. Bu dizinin her öğesi bir demet (tuple) şeklindedir: (index, element). Yani allUsers dizisindeki her kullanıcı, o kullanıcının dizideki sırası (index) ile birlikte alınır.
                        ///Array(...): .enumerated() bir Sequence döndürür. .enumerated()'ın stabil bir Identifiable tipi döndürmediği durumlar olabilir. ForEach stabil bir kimliğe ihtiyaç duyar.
                        ///id: \.offset: enumerated()'ın döndürdüğü demetin ilk elemanı (offset), kullanıcının dizideki konumunu belirten index'tir. Bu index'i, ForEach döngüsü için benzersiz kimlik (id) olarak kullanır.
                        ForEach(Array(allUsers.enumerated()), id: \.offset) { (index,user) in
                            
                            let isPrevious = (selectedIndex - 1) == index //kaydırılıp atılmış ancak animasyonu devam eden kartı
                            let isCurrent = selectedIndex == index //Şu anki kart
                            let isNext = (selectedIndex + 1) == index //Bir sonraki yüklenecek kart
                            
                            //MARK: Bütün kartları yüklemek yerine sadece 3 kart 3 kart yüklüyoruz ki optimize olsun
                            if isPrevious || isCurrent || isNext{
                                let offsetValue = cardOffsets[user.id]
                                userProfileCell(user: user,index:index)
                                //TODO: Yukarıdan asagi yerine, asagidan yukari yapmak istiyoruz. Bunun için zIndex koyacağız.
                                //TODO: Hepsinden o anki indexi çıkarırsak sanırım tersten sıralamış oluyoruz? Neyin üstte olmasını istiyoruz anlamadım
                                    .zIndex(Double(allUsers.count - index))
                                    .offset(x: offsetValue == nil ? 0 : offsetValue == true ? 900 : -900) //If the user swipe right, I'm gonna offset it 900, ıf left, -900 so I can't see it
                            }
                        }
                        
                        
                    }else{
                        ProgressView() //Yükleme ikonu çıkarır
                    }
                    
                    
                    overlaySwipingIndicators
                        .zIndex(9999)


                }
                .frame(maxHeight: .infinity)
                .padding(4)
                .animation(.smooth, value: cardOffsets)
            }
            .padding(8)
        }
        
        .task {
            await getData()
        }
        
        .toolbar(.hidden, for: .navigationBar)
    }
    
    private func userDidSelect(index: Int, isLike: Bool){
        let user = allUsers[index] //Current user
        cardOffsets[user.id] = isLike //Offset
        
        selectedIndex += 1 //Sonraki karta geç
    }
    
    private func getData() async{
        guard allUsers.isEmpty else {return} //boşsa devam ediyor, doluysa tekrar doldurmadan çıkıyor
        do{
            allUsers = try await DatabaseHelper().getUsers()

        }catch{
            print(error)
        }
    }
    
    
    //MARK: some View'lar, bir View'ın içerisine, body'nin dışına yazılır
    private var header : some View{
        HStack(spacing:0){
            HStack(spacing: 0){
                Image(systemName: "line.horizontal.3")
                    .padding(8)
                    .background(Color.black.opacity(0.001))
                    .onTapGesture {
                    }
                
                Image(systemName: "arrow.uturn.left")
                    .padding(8)
                    .background(Color.black.opacity(0.001))
                    .onTapGesture {
                        router.dismissScreen() //MARK: Hazır fonksiyon
                    }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            Text("bumble")
                .font(.title)
                .foregroundStyle(.bumbleYellow)
                .frame(maxWidth: .infinity, alignment: .center)

            
            Image(systemName: "message.badge")
                .padding(8)
                .background(Color.black.opacity(0.001))
                .onTapGesture {
                    router.showScreen(.push){_ in
                        BumbleChatsView()
                    }
                }
                .frame(maxWidth: .infinity, alignment: .trailing)


        }
        .font(.title2)
        .fontWeight(.medium)
        .foregroundStyle(.bumbleBlack)
    }
    
    private func userProfileCell(user: User, index : Int) -> some View{
        BumbleCardView(
            user: user,
            onSuperLikePressed: nil,
            onXmarkPressed: {
                userDidSelect(index: index, isLike: false)
            },
            onCheckmarkPressed: {
                userDidSelect(index: index, isLike: true)
                
            },
            onSendAComplimentPressed: nil,
            onHideAndReportPressed: {
                //
            }
        )
        .withDragGesture(
            .horizontal,
            minimumDistance: 10, //10px kaydırmazsa sağa sola gitmez. Bu sayede dikeyde ilerleyebilirim
            resets : true,
            rotationMultiplier: 1.05,
            
            onChanged: { dragOffset in
                currentSwipeOffset = dragOffset.width
            },
            onEnded: { dragOffset in
                //Sola kaydırırsa
                if dragOffset.width < -50{
                    userDidSelect(index: index, isLike: false)
                }//Sağa kaydırırsa
                else if (dragOffset.width > 50){
                    userDidSelect(index: index, isLike: true)
                }
                
            }
        )
    }
    
    private var overlaySwipingIndicators : some View{
        ZStack{
            Circle()
                .fill(.bumbleGray.opacity(0.4))
                .overlay(
                    Image(systemName: "xmark")
                        .font(.title)
                        .fontWeight(.semibold)
                )
                .frame(width: 60, height: 60)
                .scaleEffect(abs(currentSwipeOffset) > 100 ? 1.5 : 1.0) //MARK: Sağa ya da sola gitmesi farketmeksizin 1.5lik bir büyütme uygular. 100pxden küçükse aynı boyutunda kalır
                .offset(x: min(-currentSwipeOffset, 150)) //MARK: En fazla 150px(sola) ilerleyebilir
                .offset(x: -100) ///Göstergenin ekranın dışından başlamasını sağlar
                .frame(maxWidth: .infinity, alignment: .leading) //başta olmasını sağlar
//                            .background(Color.blue)
            
            
            Circle()
                .fill(.bumbleGray.opacity(0.4))
                .overlay(
                    Image(systemName: "checkmark")
                        .font(.title)
                        .fontWeight(.semibold)
                )
                .frame(width: 60, height: 60)
                .scaleEffect(abs(currentSwipeOffset) > 100 ? 1.5 : 1.0) //MARK: Sağa ya da sola gitmesi farketmeksizin 1.5lik bir büyütme uygular. 100pxden küçükse aynı boyutunda kalır
                .offset(x: max(-currentSwipeOffset, -150)) //MARK: En fazla 150px ilerleyebilir
                .offset(x: 100)
                .frame(maxWidth: .infinity, alignment: .trailing) //sonda olmasını sağlar
//                            .background(Color.blue)
            
        }
            .animation(.smooth, value: currentSwipeOffset)
    }
}

#Preview {
    RouterView{ _ in
        BumbleHomeView()

    }
}
