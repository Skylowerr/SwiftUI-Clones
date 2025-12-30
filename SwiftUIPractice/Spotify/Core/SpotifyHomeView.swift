//
//  SpotifyHomeView.swift
//  SwiftUIPractice
//
//  Created by Emirhan Gökçe on 16.11.2025.
//

import SwiftUI
import SwiftfulUI
import SwiftfulRouting

struct SpotifyHomeView: View {
    @Environment(\.router) var router
    @State private var currentUser : User? = nil
    @State private var selectedCategory : Category? = nil
    @State private var products: [Product] = []
    @State private var productRows: [ProductRow] = []
    var body: some View {
        ZStack{
            Color.spotifyBlack.ignoresSafeArea()
            
            ScrollView(.vertical){
                //MARK: LazyVStack ile en üst veya en alt kısmın sabit kalmasını sağlayabiliriz
                //MARK: Bunun için pinnedViews: .sectionHeaders veya .sectionFooters deriz
                //MARK: header veya footer olduğunu anlaması için programa Section() derken headerlı veya footerlı kısmı seçtirmemiz gerekir
                LazyVStack(spacing: 2, pinnedViews: [.sectionHeaders]) {
                    Section {
                        VStack(spacing: 15){
                            if products.isEmpty {
                                    ProgressView() // Veri yüklenirken görünür
                                        .tint(.spotifyWhite)
                                } else {
                                    recentsSection // Veri yüklendiğinde görünür
                                        .padding(.horizontal, 16)

                                }
                            
                            if let product = products.first{
                                newReleaseSection(product: product)
                                    .padding(.horizontal, 16)

                            }
                            listRows
                        }
                    } header: { ////kullanıcı aşağı kaysa bile ekranın üstünde kalmaya devam edecektir.
                        header
                    }
                }
                .padding(.top, 8)
                
                
                
            }
            .scrollIndicators(.hidden)
            .clipped() //TODO: Ne işe yarıyor. Sanırım altındaki şey üstüne geçemiyor
            //Uygulandığı view'in içeriğini, view'in kendi sınırları içine keser (clip).
            //ScrollView'un içindeki içeriğin, ScrollView'un kendi dikdörtgen çerçevesi dışına taşmasını engeller. Bu, genellikle bir görünümün sınırlarının net bir şekilde korunması istendiğinde kullanılır.
            
            .task { //TODO: Neden .task diyoruz?
                print("TASK BAŞLATILDI: getData() çağrılacak.") // <-- BU ÇIKTIYI KONTROL EDİN
                await getData()
                
            }
            .toolbar(.hidden, for: .navigationBar) //MARK: Eğer bu görünüm bir NavigationView veya NavigationStack içinde yer alıyorsa, normalde en üstte görünen standart iOS gezinme çubuğunu (üst çubuk) tamamen gizler.Spotify gibi özel arayüzlere sahip uygulamalarda, navigasyon çubuğunu gizleyip kendi özel başlık (header) görünümünüzü oluşturmak için yaygın bir yöntemdir.
        }

    } 
    private func getData() async{
        guard products.isEmpty else {return} //boşsa devam ediyor, doluysa tekrar doldurmadan çıkıyor
        do{
            currentUser = try await DatabaseHelper().getUsers().first
            products = try await Array(DatabaseHelper().getProducts().prefix(8)) //TODO: Array() ve .prefix(8) ne işe yarıyor. Neden Array kullanmak zorundayız
            
            var rows: [ProductRow] = []
            let allBrands = Set(products.map({$0.brand})) //Set diyerek her birini farklı yaparız
            for brand in allBrands{
                //let products = self.products.filter({$0.brand == brand}) //TODO: buraları anlat
                rows.append(ProductRow(title: brand?.capitalized ?? "", products: products))
            }
            productRows = rows
        }catch{
            print(error)
        }
    }
    
//    private func getData() async{
//        do{
//            print("Kullanıcı çekiliyor...")
//            currentUser = try await DatabaseHelper().getUsers().first
//            print("Kullanıcı çekildi.")
//            
//            print("Ürünler çekiliyor...")
//            //TODO: alttaki products kısmı kaldırılmıstı
//            products = try await Array(DatabaseHelper().getProducts().prefix(8))
//            print("Ürünler çekildi. Toplam: \(products.count)")
//            
//            // ...
//        }catch let error as URLError{
//            print("AĞ HATASI (URLError): \(error.localizedDescription) - Kod: \(error.errorCode)")
//        }catch let error as DecodingError{
//            print("KOD ÇÖZME HATASI (DecodingError): \(error.localizedDescription)")
//        }catch{
//            print("BİLİNMEYEN HATA: \(error.localizedDescription)")
//        }
//    }
    
    private var header : some View{
        HStack(spacing: 0){
            ZStack{
                if let currentUser{
                    ImageLoaderView(urlString: currentUser.image)
                        .background(.spotifyWhite)
                        .clipShape(Circle())
                        .onTapGesture {
                            router.dismissScreen() //ContentView a geri gitmek için
                        }
                }
            }
            .frame(width: 35, height:35)
            
            ScrollView(.horizontal){
                HStack(spacing : 8){
                    
                    //MARK: CaseIterable ne demek? .allCases ı mı kullanabiliyoruz demek. EVET
                    ForEach(Category.allCases, id: \.self){ category in
                        SpotifyCategoryCell(title: category.rawValue.capitalized, isSelected: category == selectedCategory)
                        
                            .onTapGesture {
                                withAnimation {
                                    selectedCategory = category
                                }
                            }
                    }
        
                }
            }
            .scrollIndicators(.hidden)

            
        }
        .padding(.vertical, 24)
        .padding(.leading, 8)
        .background(.spotifyBlack)
    }
    
    private var recentsSection : some View{
        //ozel komut
        NonLazyVGrid(columns: 2, alignment: .center, spacing: 10, items: products) { product in
            if let product {
                SpotifyRecentsCell(imageName: product.firstImage, title: product.title)
                    .asButton(.press) {
                        goToPlaylistView(product: product)
                    }
            }
        }
        
    }
    private func goToPlaylistView(product : Product){
        ///Önkoşul Kontrolü: Fonksiyonun/bloğun devam etmesi için gerekli koşulu kontrol et.
        guard let currentUser else {return} //TODO: Optional olduğu için mi guard let yapıyoruz? if let yapmıyor muyduk optionallarda ?
        
        router.showScreen(.push){ _ in
            SpotifyPlaylistView(product: product, user: currentUser)
        }
    }
    
    //TODO: Bunu func, üsttekini var yapmamın sebebi, buraya dışarıdan product girmem sanırım
    private func newReleaseSection(product: Product) -> some View{
        SpotifyNewReleaseCell(
            imageName: product.firstImage,
            headline: product.brand,
            subheadline: product.category,
            title: product.title,
            subtitle: product.description,
            onAddToPlaylistPressed: {},
            onPlayPressed: {
                goToPlaylistView(product: product)
            }
        )
    }
    
    private var listRows : some View{
        ForEach(productRows) { row in
            VStack(spacing:8){
                Text(row.title)
                    .font(.title)
                    .fontWeight(.semibold)
                    .foregroundStyle(.spotifyWhite)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 16)

                ScrollView(.horizontal){
                    HStack(alignment : .top , spacing:16) {
                        ForEach(row.products) { product in
                            ImageTitleRowCell(
                                imageName: product.firstImage,
                                title: product.title,
                                imageSize: 120
                            )
                            .asButton {
                                goToPlaylistView(product: product)
                            }
                        }
                    }
                    .padding(.horizontal, 16)
                    
                }
                .scrollIndicators(.hidden)
            }
        }
    }
}



#Preview {
    RouterView{ _ in
        SpotifyHomeView()

    }
}
