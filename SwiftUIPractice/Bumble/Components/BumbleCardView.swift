//
//  BumbleCardView.swift
//  SwiftUIPractice
//
//  Created by Emirhan Gökçe on 20.11.2025.
//

import SwiftUI
import SwiftfulUI

struct BumbleCardView: View {
    var user : User = .mock
    var onSuperLikePressed  : (() ->Void)? = nil
    var onXmarkPressed  : (() ->Void)? = nil
    var onCheckmarkPressed  : (() ->Void)? = nil
    var onSendAComplimentPressed  : (() ->Void)? = nil
    var onHideAndReportPressed  : (() ->Void)? = nil
    
    @State private var cardFrame : CGRect = .zero
    
    var body: some View {
        
        ScrollView(.vertical){
            //MARK: LazyVStack, tek bir sütunda sıralama yaparken, LazyVGrid, birden çok sütunda sıralama yapabilir. Onda ek olarak columns: [GridItem] parametresi vardır.
            
            LazyVStack(spacing:0){
                headerCell
                    .frame(height: cardFrame.height) //GeomtryReader kullanarak, her cihazda güzel bir yükseklik değeri elde ediyoruz
                    
                aboutMeSection
                .padding(.horizontal,24)
                .padding(.vertical,24)
                
                
                myInterestSection
                    .padding(.horizontal,24)
                    .padding(.vertical,24)
                
                //TODO: imageların urllerini değiştirmemiz gerekti? neden?
                ForEach(user.images, id: \.self){image in
                    ImageLoaderView(urlString: image)
                        .frame(height: cardFrame.height)
                    
                    
                locationSection
                    .padding(.horizontal,24)
                    .padding(.vertical,24)
                
                footerSection
                    .padding(.top,60)
                    .padding(.bottom,60)
                    .padding(.horizontal,32)
                
                

                }

            }
        }
        .scrollIndicators(.hidden)
        .background(.bumbleBackgroundYellow)
        
        .overlay(
            superlikeButton
                .padding(24)
            , alignment: .bottomTrailing
        )
        
        .cornerRadius(32)
        .readingFrame { frame in
            cardFrame = frame
        }
            
    }
    
    //TODO: ->some View dememizin nedeni, aynı ekranda olduğumuz için mi? Gerçi text biçimlendiriyoruz sadece muhtemelen o yüzden
    private func sectionTitle(title : String) -> some View{
        Text(title)
            .font(.body)
            .foregroundStyle(.bumbleGray)
    }
    
    
    private var headerCell : some View{
        ZStack(alignment: .bottomLeading){
            ImageLoaderView(urlString: user.image)
            
            VStack(alignment: .leading, spacing: 8){
                Text("\(user.firstName), \(user.age)")
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                
                HStack(spacing:4){
                    Image(systemName: "suitcase")
                    Text(user.work)
                }
                HStack(spacing:4){
                    Image(systemName: "graduationcap")
                    Text(user.education)
                }
                BumbleHeartView()
                    .onTapGesture {
                        //
                    }
            }
            .padding(24)
//                    .background(.red)
            .font(.callout)
            .fontWeight(.medium)
            .foregroundStyle(.bumbleWhite)
            .frame(maxWidth: .infinity, alignment: .leading) //TODO: Neden .infinity diyoruz? Çünkü aşağıdaki opacity'nin bütün satırda uygulanmasını istiyoruz. Yarısında uygulanıp, yarısında uygulanmaması iğrenç duruyor
//                    .background(Color.blue)
            .background(
                LinearGradient(
                    colors: [ //TODO: Neden 2 tane aynı opacity var
                        .bumbleBlack.opacity(0),
                        .bumbleBlack.opacity(0.6),
                        .bumbleBlack.opacity(0.6),
                    ],
                    startPoint: .top,
                    endPoint: .bottom
                )
            )
            
        }
    }
    
    private var aboutMeSection : some View{
        VStack(alignment: .leading, spacing: 12) {
            sectionTitle(title: "About Me")
            
            Text(user.aboutMe)
                .font(.body)
                .fontWeight(.semibold)
                .foregroundStyle(.bumbleBlack)
            
            HStack(spacing: 0){
                BumbleHeartView()
                
                Text("Send a Compliment")
                    .font(.caption)
                    .fontWeight(.semibold)
            }
            .padding([.horizontal, .trailing], 8) //TODO: YENI KULLANIM
            .background(.bumbleYellow)
            .cornerRadius(32)
            .onTapGesture {
                onSendAComplimentPressed?()
            }
            
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var myInterestSection : some View{
        VStack(alignment: .leading,spacing:12) {
            VStack(alignment: .leading, spacing:8){
                sectionTitle(title: "My basics")
                InterestPillGridView(interests: user.basics)
            }
            VStack(alignment: .leading, spacing:8){
                sectionTitle(title: "My interest")
                InterestPillGridView(interests: user.interests)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var locationSection : some View{
        VStack(alignment: .leading, spacing: 12){
            HStack(spacing: 8){
                Image(systemName: "mappin.and.ellipse.circle.fill")
                Text(user.firstName + "'s Location")
            }
            .foregroundStyle(.bumbleGray)
            .font(.body)
            .fontWeight(.medium)
            
            Text("20 miles away")
                .font(.headline)
                .foregroundStyle(.bumbleBlack)
            
            InterestPillView(iconName: nil, emoji: "🇹🇷", text: "Lives in Ankara")
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var footerSection : some View{
        VStack{
            HStack{
                Circle()
                    .fill(.bumbleYellow)
                    .overlay(
                        Image(systemName: "xmark")
                            .font(.largeTitle)
                            .fontWeight(.semibold)
                            
                    )
                    .frame(width:60, height: 60)
                    .onTapGesture {
                        onXmarkPressed?()
                    }
                
                Spacer(minLength: 0) //TODO: Bu ne demek?
                
                Circle()
                    .fill(.bumbleYellow)
                    .overlay(
                        Image(systemName: "checkmark")
                            .font(.largeTitle)
                            .fontWeight(.semibold)
                            
                    )
                    .frame(width:60, height: 60)
                    .onTapGesture {
                        onCheckmarkPressed?()
                    }
            }
            
            Text("Hide and Report")
                .font(.headline)
                .foregroundStyle(.bumbleGray)
                .padding(8)
                .background(Color.black.opacity(0.001))
                .onTapGesture {
                onHideAndReportPressed?()
                }
        }
    }
    
    private var superlikeButton : some View{
        Image(systemName: "hexagon.fill")
            .foregroundStyle(.bumbleYellow)
            .font(.system(size: 60))
            .overlay(
                Image(systemName: "star.fill")
                    .foregroundStyle(.bumbleBlack)
                    .font(.system(size: 30, weight: .medium))
                
            )
            .onTapGesture {
                onSuperLikePressed?()
            }
    }
}

#Preview {
    BumbleCardView()
    //View kısmına Rectangle() diyerek ayarlayabilirsin görünümü
        .padding(.vertical,40)
        .padding(.horizontal,16)
}
