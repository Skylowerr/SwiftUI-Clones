//
//  InterestPillView.swift
//  SwiftUIPractice
//
//  Created by Emirhan Gökçe on 20.11.2025.
//

import SwiftUI

struct InterestPillView: View {
    
    var iconName : String? = "heart.fill" //icon olmayabilir, onun yerine emoji kullanabiliriz
    var emoji : String? = "📱" //emoji olmayabilir, onun yerine ikon kullanabiliriz
    var text: String = "Graduate Degree"
    
    var body: some View {
        HStack(spacing:4){
            if let iconName{
                Image(systemName: iconName)
            } else if let emoji{
                Text(emoji) //MARK: Emojiler stringtir, Image degil.
            }
            Text(text)
        }
        .font(.callout)
        .fontWeight(.medium)
        .padding(.vertical,6)
        .padding(.horizontal,12)
        .foregroundStyle(.bumbleBlack)
        .background(.bumbleLightYellow)
        .cornerRadius(32)
    }
}

#Preview {
    VStack {
        InterestPillView(iconName: nil) //iconName = nil olduğu için, en baştaki emojiyi kullandı
        InterestPillView() //TODO: BURADA HICBIR SEY DEMEMIZE RAGMEN NEDEN icon kullandı? Çünkü hem emoji, hem de icon değeri vardır. if let iconName daha önce koyduğumu için oradaki if e girer

    }
}
