//
//  BumbleChatPreview.swift
//  SwiftUIPractice
//
//  Created by Emirhan Gökçe on 23.11.2025.
//

import SwiftUI

struct BumbleChatPreview: View {

    var imageName: String = Constants.randomImage
    var percentageRemaining : Double = Double.random(in: 0...1)
    var hasNewMessage: Bool = true
    var userName : String
    var lastChatMessage : String? = "This is the last messagejlksdgfjkdskfgjkdlsfgklsdjkflg"
    var isYourMove : Bool = true
    var size : CGFloat = 75
    
    var body: some View {
        HStack(spacing:16){
            BumbleProfileImageView(
                imageName: imageName,
                percentageRemaining: percentageRemaining,
                hasNewMessage: hasNewMessage,
                size: size
            )
            VStack(alignment : .leading, spacing:3){
                HStack(spacing: 0){
                    Text(userName)
                        .font(.headline)
                        .foregroundStyle(.bumbleBlack)
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity, alignment: .leading)

                    if hasNewMessage{
                        Text("YOUR MOVE")
                            .font(.caption2)
                            .bold()
                            .padding(.vertical,4)
                            .padding(.horizontal,6)
                            .background(.bumbleYellow) //TODO: Burasını unuttum
                            .clipShape(RoundedRectangle(cornerRadius: 32))
                    }
                }
                if let lastChatMessage{
                    Text(lastChatMessage)
                        .font(.subheadline)
                        .foregroundStyle(.bumbleGray)
                        .padding(.trailing,16)
                }
                
            }
        }
        .lineLimit(1)

//        .background(Color.blue)
        .padding(.leading)

        }
}

#Preview {
    VStack(alignment : .leading){
        BumbleChatPreview(
            userName : "Skyler"
        )
        BumbleChatPreview(
            userName : "Skyler"
        )
        
    }
}
