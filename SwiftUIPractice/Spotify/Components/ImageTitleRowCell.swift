//
//  ImageTitleRowCell.swift
//  SwiftUIPractice
//
//  Created by Emirhan Gökçe on 16.11.2025.
//

import SwiftUI

struct ImageTitleRowCell: View {
    var imageName : String = Constants.randomImage
    var title : String = "Some Item Name"
    var imageSize : CGFloat = 100
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8){
            ImageLoaderView(urlString: imageName)
                .frame(width: imageSize, height: imageSize)
            
            Text(title)
                .font(.callout)
                .foregroundStyle(.spotifyLightGray)
                .padding(4) //Biraz ortalamak için. backgrounda göre hizalayabilirsin
                .lineLimit(2)
        }
        .frame(width: imageSize) //Text sağa doğru taşmasın diye
        //.background(.red)
    }
}

#Preview {
    ZStack {
        Color.black.ignoresSafeArea()
        ImageTitleRowCell()
    }
}
