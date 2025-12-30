//
//  PlaylistHeaderCell.swift
//  SwiftUIPractice
//
//  Created by Emirhan Gökçe on 17.11.2025.
//

import SwiftUI
import SwiftfulUI

struct PlaylistHeaderCell: View {
    
    var height : CGFloat = 300
    var title: String = "Some playlist title here "
    var subtitle: String = "Subtitle goes here"
    var imageName : String = Constants.randomImage
    var shadowColor : Color = .spotifyBlack.opacity(0.8)
    
    var body: some View {
        Rectangle() //Rectangle sayesinde, internetten yüklenen resim (ImageLoaderView), üzerine yerleştirildiği (overlay ile) bu sabit, boyutlandırılmış konteynere göre yerleşir ve boyutlanır.
            .opacity(0) //Dikdörtgenin kendi rengini görünmez yapar, böylece ekranda sadece üzerine yerleştirilen resim ve metin görünür.
            .overlay(
                ImageLoaderView(urlString: imageName)

            )
        //TODO: Tek bir overlay de kullanabilirsin fakat 2ye ayırınca daha esnek işlem yapabiliyorsun?
            .overlay(
                VStack(alignment : .leading, spacing : 8){
                    Text(subtitle)
                        .font(.headline)
                    Text(title)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                }
                    .foregroundStyle(.spotifyWhite)
                    .padding(16)
                    .frame(maxWidth: .infinity, alignment: .leading)
                //Yazıyı daha da belirgin yapabilmek için LinearGradient bir background koyarız(opacityli)
                    .background(
                        //TODO: Neden birisine 0, diğerine 1 diyoruz opacitysine
                        LinearGradient(colors: [shadowColor.opacity(0),shadowColor], startPoint: .top, endPoint: .bottom)
                        //topta gradient şeffaf, bottomda ise koyu bir gölge oluşturur
                    )
                , alignment: .bottomLeading //TODO: metnin ve gölgenin resmin sol alt köşesine sıkıca sabitlenmesini sağlarsınız.
            )
            .asStretchyHeader(startingHeight: height) //TODO: Aşağı doğru kaydırınca uzamasını saglıyor (.offset sayesinde)
        
    }
}

#Preview {
    ZStack {
        Color.black.ignoresSafeArea()
        ScrollView {
            PlaylistHeaderCell()
        }
        .ignoresSafeArea()
    }
}
