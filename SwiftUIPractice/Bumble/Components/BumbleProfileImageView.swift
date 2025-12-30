//
//  BumbleCircleView.swift
//  SwiftUIPractice
//
//  Created by Emirhan Gökçe on 23.11.2025.
//

import SwiftUI


struct BumbleProfileImageView: View {
    var imageName  = Constants.randomImage
    var percentageRemaining : Double = Double.random(in: 0...1)
    var hasNewMessage : Bool = true
    var size : CGFloat = 75 //MARK: Bir şey demezsek otomatik olarak boyutları 75 olur. Dışarıdan değer verirsek ona göre boyutları değişir.
    
        var body: some View {
            ZStack{
                ///Arka Plan Halkası. Gri renkte, sabit ve tam bir çember çizer. Bu, ilerleme çubuğunun altında bir çerçeve (iz) görevi görür. stroke diyerek daire çizmesi yerine çember çizmesini sağlarız(sadece kenarlar)
                
                Circle()
                    .stroke(.bumbleGray, lineWidth: 2)
                
                ///İlerleme yayı. Bu, çemberin sadece belirli bir bölümünü (percentageRemaining kadar) çizen anahtardır. Sarı renkte (.bumbleYellow) ilerleme çubuğunu oluşturur.
                Circle()
                    .trim(from: 0, to: percentageRemaining) //MARK: Bir şeklin belirli bir kısmını çizmek için kullanılır
                    .stroke(.bumbleYellow, lineWidth: 4)
                    .rotationEffect(Angle(degrees: -90))//sağdan başlıyordu. Şimdi yukarıdan başlıyor(270 derece = -90)
                    .scaleEffect(x: -1, y: 1, anchor: .center) //sağ yerine sol tarafa döndürüyoruz
                
                ImageLoaderView(urlString: imageName)
                    .clipShape(Circle())
                    .padding(5)
                
                
            }
            .frame(width: size, height: size)
            
            //.overlay modifier'ı, yukarıdaki tüm ZStack View'ının üzerine, genellikle köşelere yerleştirilen, ikincil bir öğe eklemek için kullanılır. Burada bildirim balonu eklenir.
            //MARK: Nerede .overlay, Nerede ZStack kullanıyoruz anlat
            //MARK: Burası sağ alt köşede çıkan bell
            .overlay(
                ZStack{ //Beyaz halkayı ve sarı dolguyu üst üste yığmak için kullanılır.
                    if hasNewMessage {
                        //Bell'in dışarıdaki beyazlığı
                        Circle()
                            .fill(.bumbleWhite) ///Baloncuğun Çerçevesi . Dışarıdan görünen ince beyaz halkayı oluşturur.
                        
                        //Bell'in içerideki sarılığı
                        Circle()
                            .fill(.bumbleYellow) ///Baloncuğun Dolgusu.Beyaz çemberin içine yerleşen ve etrafında ince beyaz bir sınır bırakan sarı dolguyu oluşturur.
                            .padding(4)
                        
                    }
                }
                    .frame(width: 24,height:24)
                    .offset(x: 2, y: 2)///Hassas Ayarlama. Baloncuğu .bottomTrailing konumundan biraz içeri doğru kaydırarak kenara tam yapışmasını engeller ve görsel olarak daha estetik hale getirir.
                ,alignment: .bottomTrailing //ZStack'in sağ alt köşesi
            )
        }
}



#Preview {
    VStack{
        BumbleProfileImageView()
        BumbleProfileImageView(hasNewMessage: false)
        BumbleProfileImageView(percentageRemaining: 1)
        BumbleProfileImageView(percentageRemaining: 0)


    }
}
