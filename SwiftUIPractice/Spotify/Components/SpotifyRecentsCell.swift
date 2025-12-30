//
//  SpotifyRecentsCell.swift
//  SwiftUIPractice
//
//  Created by Emirhan Gökçe on 16.11.2025.
//

import SwiftUI

struct SpotifyRecentsCell: View {
    
    var imageName : String = Constants.randomImage
    var title: String = "Some random title"
    var body: some View {
        HStack(spacing:16){
            ImageLoaderView(urlString: imageName)
                .frame(width: 55, height: 55)
            
            Text(title)
                .font(.callout)
                .fontWeight(.semibold)
                .lineLimit(2) //MARK: Eğer metin çok uzunsa 2 satır ile sınırlar
        }
        .padding(.trailing,10) //TODO: Text sağa çok yatıktı. Böyle olunca biraz daha ortaladık?
        .frame(maxWidth: .infinity, alignment: .leading)
        .themeColors(isSelected: false)
        .background(Color.blue.cornerRadius(6))
    }
}

#Preview {
    ZStack{
        Color.black.ignoresSafeArea()
        
        VStack{
            HStack{
                SpotifyRecentsCell()
                SpotifyRecentsCell()
            }
            HStack{
                SpotifyRecentsCell()
                SpotifyRecentsCell()
            }
        }
    }
}
