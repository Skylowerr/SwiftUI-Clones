//
//  BumbleFilterView.swift
//  SwiftUIPractice
//
//  Created by Emirhan Gökçe on 19.11.2025.
//

import SwiftUI

struct BumbleFilterView: View {
    var options : [String] = ["Everyone","Trending"]
    @Binding  var selection : String //TODO: @State'den @Binding'e çekiyoruz. Nedeni diğer ekranlarda kullanabilmek için mi? Ayrıca, neden initializer'ını kaldırıyoruz?
    //MARK: Evet, amaç tam da dediğiniz gibi bu View'da yapılan seçimin (üst View'da kullanılan) diğer ekranlarda/bileşenlerde kullanılabilmesini sağlamaktır. BumbleFilterView verinin sahibi değil, veriyi değiştiren aracıdır.
    //MARK: BumbleFilterView(selection: $someStateVariable) şeklinde çağrılırken, referans dışarıdan geldiği için, sizin el ile bir init yazmanıza gerek kalmaz; Swift bunu sizin için otomatik olarak halleder.
    
    
    @Namespace private var namespace
    var body: some View {
        HStack(alignment: .top){ //MARK: Tıklandığında textin yukarı bounce'ını engellemek için
            
            //options are strings. Strings are hashable -> id : \.self yazmalisin
            ForEach(options, id : \.self){ option in
                VStack(spacing : 8){
                    Text(option)
                        .frame(maxWidth: .infinity)
                        .font(.subheadline)
                        .fontWeight(.medium)
                    
                    if selection == option{
                        RoundedRectangle(cornerRadius: 2)
                            .frame(height: 1.5)
                            .matchedGeometryEffect(id: "selection", in: namespace)
                        //MARK: id: "selection": Her bir seçenek ("Everyone", "Trending") tıklandığında, koşullu olarak oluşturulan RoundedRectangle'a bu aynı id atanır.
                        
                        //MARK: in: namespace: Bu etkiye dahil olan tüm View'ların hangi namespace (isim alanı) içinde eşleşeceğini belirtir.
                        
                        
                    }
                }
                .padding(.top, 8)
                .background(Color.black.opacity(0.001))
                .foregroundStyle(selection == option ? .bumbleBlack : .bumbleGray)
                .onTapGesture {
                    selection = option
                }
            }
        }
        .animation(.smooth, value: selection) //(selection) değiştiğinde matchedGeometryEffect'in bu akıcı geçişi yapmasını tetikler.
    }
}


//TODO: Bunu neden yaptık? Diğer ekranlardan ulaşıyormuşuz gibi mi yapıyoruz? EVET
//TODO: Ayrıca, burada selection için neden @Binding yerine @State kullanıyoruz?
//MARK: @State private var selection = "Everyone" değişkeni, BumbleFilterView'a bağlanılacak verinin "sahibi" rolünü üstlenir.
fileprivate struct BumbleFilterViewPreview: View{
    var options : [String] = ["Everyone","Trending","Hello"]
    @State private var selection = "Everyone"
    var body: some View{
        BumbleFilterView(options: options, selection: $selection)

    }
}

#Preview {
    BumbleFilterViewPreview()
        .padding()
}
