//
//  SongRowCell.swift
//  SwiftUIPractice
//
//  Created by Emirhan Gökçe on 17.11.2025.
//

import SwiftUI

struct SongRowCell: View {
    var imageSize : CGFloat = 50
    var imageName : String = Constants.randomImage
    var imageTitle : String = "Some song name goes here"
    var subtitle : String? = "Some artist name" //TODO: Burada subtitle neden optional?
    
    //Bunların Optional ((() -> Void)?) olmasının nedeni, hücrenin her zaman tıklanabilir olması gerekmemesidir.
    var onCellPressed : (() -> Void)? = { }
    var onEllipsesPressed : (() -> Void)? = { }


    var body: some View {
        HStack(spacing:8){
            ImageLoaderView(urlString: imageName)
                .frame(width: imageSize, height: imageSize)
            
            VStack(alignment: .leading ,spacing: 4) {
                Text(imageTitle)
                    .font(.body)//default
                    .fontWeight(.medium)
                    .foregroundStyle(.spotifyWhite)
                
                //TODO: Optional olduğu için mi if let koyuyoruz?
                if let subtitle{
                    Text(subtitle)
                        .font(.callout)
                        .foregroundStyle(.spotifyLightGray)

                }
            }
            .lineLimit(2)
            .frame(maxWidth: .infinity, alignment: .leading) //Text tüm ekranı kaplasın diye
//            .background(Color.blue)
            
            Image(systemName: "ellipsis")
                .font(.subheadline)
            .foregroundStyle(.spotifyWhite)
            .padding(16) //Tıklanabilir alanı büyültüyoruz
            .background(Color.black.opacity(0.001)) //TODO: Tıklanabilir olması için bir opacity koyuyoruz. opacity değeri 0dan farklı olmalı.
            .onTapGesture {
                onEllipsesPressed?() // Yalnızca 'onEllipsesPressed' nil değilse çalıştır.
            }
            
        }
        .background(Color.black.opacity(0.001))
        .onTapGesture {
            onCellPressed?()
        }
    }
}

#Preview {
    ZStack {
        Color.spotifyBlack.ignoresSafeArea()
        VStack {
            SongRowCell()
            SongRowCell()
            SongRowCell()
            SongRowCell()
            SongRowCell()

        }
    }
}
