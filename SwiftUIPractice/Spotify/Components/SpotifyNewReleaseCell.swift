//
//  SpotifyNewReleaseCell.swift
//  SwiftUIPractice
//
//  Created by Emirhan Gökçe on 16.11.2025.
//

import SwiftUI

struct SpotifyNewReleaseCell: View {
    
    var imageName: String = Constants.randomImage
    var headline: String? = "New release from"
    var subheadline : String? = "Some artist"
    
    var title: String? = "Some Playlist"
    var subtitle: String? = "Single - title"
    
    var onAddToPlaylistPressed : (() -> Void)? = nil //TODO: Bu fonkyison niye? Optional yaptığım için uygulamanın her yerinde kullanmama gerek yok. İhtiyacım olan yerde yazarım
    var onPlayPressed : (() -> Void)? = nil //MARK: Bu, hücrenin ana tıklama eylemini (parçayı/albümü oynatmayı) dışarıdaki view'e bildirmek için kullanılır.
    
    var body: some View {
        VStack(spacing:16){
            HStack(spacing: 8){
                ImageLoaderView(urlString: imageName)
                    .frame(width: 50, height: 50)
                    .clipShape(Circle())
                
                VStack(alignment: .leading ,spacing:2){
                    if let headline{
                        Text(headline)
                            .foregroundStyle(.spotifyLightGray)
                            .font(.callout)
                    }
                    if let subheadline{
                        Text(subheadline)
                            .font(.title2)
                            .fontWeight(.medium)
                            .foregroundStyle(.spotifyWhite)
                    }
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading) //TODO: Neden .infinity dedik
            
            HStack{
                ImageLoaderView(urlString: imageName)
                    .frame(width: 150, height: 150)
                VStack(alignment: .leading, spacing : 32){
                    VStack(alignment: .leading, spacing:2){
                        if let title{
                            Text(title)
                                .fontWeight(.semibold)
                                .foregroundStyle(.spotifyWhite)
                        }
                        
                        if let subtitle{
                            Text(subtitle)
                                .foregroundStyle(.spotifyLightGray)
                        }
                    }
                    .font(.callout)
                    HStack(spacing:0){
                        Image(systemName: "plus.circle")
                            .foregroundStyle(.spotifyLightGray)
                            .font(.title3)
                        //TODO: Galiba tıklanabilir alanı büyültüyoruz. Fakat .opacity değeri çok küçük old. için kullanıcı bunu görmüyor
                            .padding(4)
                            .background(Color.black.opacity(0.001))
                            .onTapGesture {
                                onAddToPlaylistPressed?() //Böylece, kullanıcı hücredeki görsel, başlık veya arkaplana tıkladığında, bu olay tetiklenir ve çalma eylemi başlatılır.
                            }
                            .offset(x: -4) //Yukarıdaki yazılarla hizalamak için. Padding olarak her yerden 4 verdiğimiz için 4 çıkarmamız lazım
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        //Spacer() TODO: Spacer yerine maxFrame ile yapabilirsin?
                        
                        
                        Image(systemName: "play.circle.fill")
                            .foregroundStyle(.spotifyWhite)
                            .font(.title)
//                            .onTapGesture {
//                                //Burayı tıklanabilir yapmaktansa, geri kalan her yeri tıklanaiblir yapıyorum. Kullanıcı arkaplana da  tıklasa, oynat butona da tıklasa aynı işlevi yerine getirtmek istiyorum.
//                            }
                    }
                }
                .padding(.trailing,16)

            }
            .themeColors(isSelected: false)
            .cornerRadius(8)
            .onTapGesture {
                onPlayPressed?()
            }

        }
    }
}

#Preview {
    ZStack{
        Color.black.ignoresSafeArea()
        SpotifyNewReleaseCell()
            .padding()
    }

}
