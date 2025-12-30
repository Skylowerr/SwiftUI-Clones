//
//  ImageLoaderView.swift
//  SwiftUIPractice
//
//  Created by Emirhan Gökçe on 15.11.2025.
//

import SwiftUI
import SDWebImageSwiftUI

struct ImageLoaderView: View {
    
    var urlString : String = Constants.randomImage
    var resizingMode : ContentMode = .fill
    
    var body: some View {
        Rectangle() ///bir resmi internetten yüklerken, resim yüklenene kadar bir boyutu olmayabilir veya yanlış boyutlanabilir. Rectangle() view'i ise kapsayıcı view'in (parent view) kendisine verdiği tüm alanı doldurmaya çalışır. Bu, ImageLoaderView'ı kullanan dışarıdaki kapsayıcı view'in (örneğin SpotifyHomeView'daki bir Rectangle veya Circle) net bir çerçeve oluşturmasını sağlar.
            .opacity(0.001)
            .overlay(
                ///Siz WebImage'ı bu Rectangle üzerine .overlay() ile yerleştiriyorsunuz. Bu Rectangle, WebImage'ın ne kadar alana yayılacağını (ve daha sonra .clipped() ile nasıl kesileceğini) tanımlayan çerçeveniz haline gelir.
                WebImage(url: URL(string:urlString)) //Hazır Fonksiyon
                    .resizable()
                    .indicator(.activity) //hazır kütüphaneden çekildi. Resim internetten yüklenirken kullanıcıya görsel geri bildirim sağlamak için bir yükleme göstergesi (activity indicator) ekler. Beklerken uygulamanın donmadıgını anlamasını sağlamak için
                
                
                    .aspectRatio(contentMode: resizingMode) //TODO: Görüntünün en/boy oranının korunmasını sağlar. resmin uygulandığı view'in çerçevesini tamamen doldurmasını sağlar (.fill veya .fit)
                    .allowsHitTesting(false)//WebImage'in dokunma olaylarını (tıklamalar, sürüklemeler, vb.) almasını engeller.
            )
            .clipped()
        //view'ın kendisine uygulanan sınırların dışına taşan içeriği temizlemek için kullanılır.
        //aspectRatio(contentMode: .fill) Etkisi  .fill boyutlandırıldığında, resmin bir kısmı çerçevenin dışına taşabilir.

    }
}

#Preview {
    ImageLoaderView()//urlString ve resizingMode let yerine var olduğu için burada bile initialize edebiliriz aslında
        .clipShape(RoundedRectangle(cornerRadius: 30))
        .padding(40)
        .padding(.vertical, 60)
}
