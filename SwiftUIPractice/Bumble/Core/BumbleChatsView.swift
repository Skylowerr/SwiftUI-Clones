//
//  BumbleChatsView.swift
//  SwiftUIPractice
//
//  Created by Emirhan Gökçe on 23.11.2025.
//

import SwiftUI

struct BumbleChatsView: View {
    @Environment(\.router) var router //TODO: Ne işe yarıyor?

    @State private var allUsers: [User] = []
    var body: some View {
        ZStack{
            Color.bumbleWhite.ignoresSafeArea()
            
            
            
            VStack(spacing:16){
                header
                    .padding(16)
                
                matchQueueSection
                
                
                
                recentChatsSection
                
                
//                Spacer()
            }
            
        }
        
        .task {
            await getData()
        }
        .toolbarVisibility(.hidden, for: .navigationBar) //TODO: Kapa aç yap dene
    }
    
    
    
    private func getData() async{
        guard allUsers.isEmpty else {return} //boşsa devam ediyor, doluysa tekrar doldurmadan çıkıyor
        do{
            allUsers = try await DatabaseHelper().getUsers()

        }catch{
            print(error)
        }
    }
    
    private var header : some View{
        HStack(spacing:0){
            Image(systemName: "line.horizontal.3")
                .onTapGesture {
                    router.dismissScreen()
                }
            Spacer(minLength: 0)//TODO: Bu ne işe yarıyor? kullanmasam ne olur
            Image(systemName: "magnifyingglass")

        }
        .font(.title)
        .fontWeight(.medium)
    }
    
    private var matchQueueSection : some View{
        VStack(alignment: .leading, spacing:8){
            Group{ //TODO: Group ile HStack farkı ne
                Text("Match Queue")
                +
                Text("(\(allUsers.count))")
                    .foregroundStyle(.bumbleGray)
            }
            .padding(.horizontal,16)
            
            ScrollView(.horizontal){
                LazyHStack(spacing:16){
                    ForEach(allUsers) { user in
                        BumbleProfileImageView(
                            imageName: user.images.randomElement()!,
                            percentageRemaining: Double.random(in: 0...1),
                            hasNewMessage: Bool.random(), //TODO: Yaz kenara
                            
                        )
                    }
                }
                .padding(.horizontal,16)

            }
            .frame(height: 100) //TODO: Sanırım LazyHStack diyince çok fazla yer kaplıyor. O yüzden belirli bir alan veriyoruz
//                    .background(.blue)
            .scrollIndicators(.hidden)
            

        }
        .frame(maxWidth: .infinity,alignment: .leading)
    }
    
    private var recentChatsSection : some View{
        VStack(alignment: .leading, spacing:8){
            HStack(spacing:0){
                Group{ //TODO: Group ile HStack farkı ne
                    Text("Chats")
                    +
                    Text("(Recent)")
                        .foregroundStyle(.bumbleGray)
                }
                Spacer(minLength: 0)
                Image(systemName: "line.horizontal.3.decrease")
                    .font(.title2)
            }
            .padding(.horizontal,16)
            
            ScrollView(.vertical){
                LazyVStack(spacing:16){
                    ForEach(allUsers) { user in
                        BumbleChatPreview(
                            imageName: user.images.randomElement()!,
                            percentageRemaining: Double.random(in: 0...1),
                            hasNewMessage: Bool.random(),
                            userName: user.firstName,
                            lastChatMessage: user.aboutMe,
                            isYourMove: Bool.random(),
                            
                        )
                    }
                }
                .padding(6)

            }
            .scrollIndicators(.hidden)
            

        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

#Preview {
    BumbleChatsView()
}
