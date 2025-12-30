//
//  SpotifyPlaylistView.swift
//  SwiftUIPractice
//
//  Created by Emirhan Gökçe on 17.11.2025.
//

import SwiftUI
import SwiftfulUI
import SwiftfulRouting

struct SpotifyPlaylistView: View {
    @Environment(\.router) var router
    var product : Product = .mock // INITIALIZER
    var user : User = .mock //INITIALIZER
    
    @State private var products : [Product] = []
    
    @State private var showHeader : Bool = true
//    @State private var offset : CGFloat = 0
    
    var body: some View {
        ZStack{
            Color.spotifyBlack.ignoresSafeArea()
            ScrollView(.vertical){
                LazyVStack(spacing:12){
                    PlaylistHeaderCell(
                        height: 250,
                        title: product.title,
                        subtitle: product.brand ?? "Random Brand",
                        imageName: product.thumbnail ?? "Random Thumbnail"
                    )
                    
                    .readingFrame { frame in
                        showHeader = frame.maxY < 150
                    }
                    
                    
//                    .overlay(
//                        GeometryReader{geometry in
//                            Text("")
//                                .frame(maxWidth: .infinity, maxHeight: .infinity)
//                                .background(Color.red)
//                        }
//                    )
                    
                    PlaylistDescriptionCell(
                        descriptionText: product.description,
                        userName: user.firstName,
                        subheadline: product.category ?? "",
                        onAddToPlaylistPressed: nil,
                        onDownloadPressed: nil,
                        onASharePressed: nil,
                        onEllipsisPressed: nil,
                        onShufflePressed: nil,
                        onPlayPressed: nil
                    )
                    .padding(.horizontal, 16)
                    
                    ForEach(products) { product in
                        SongRowCell(
                            imageSize: 50,
                            imageName: product.firstImage,
                            imageTitle: product.title,
                            subtitle: product.brand,
                            onCellPressed: {goToPlaylistView(product: product)},
                            onEllipsesPressed: {}
                        )
                        .padding(.leading, 16) //Böyle yapınca sağa sola daha iyi yanaşıyor sanırım

                    }
                    
                }
            }
            .scrollIndicators(.hidden) //TODO: BU NE ISE YARIYOR SOR
//            Text("\(offset)")
//                .background(Color.red)
//            
            header
                .frame(maxHeight: .infinity, alignment: .top)


        }
        .task {
            await getData()
        }
        //TODO: AÇIKLA
        .toolbar(.hidden, for: .navigationBar)
    }
    
    //TODO: Diğer yerden çekmemizin bir nedeni var mı?
    private func getData() async{
        do{
            products = try await DatabaseHelper().getProducts()
        }catch{
            //
        }
    }
    
    private func goToPlaylistView(product : Product){
        ///Önkoşul Kontrolü: Fonksiyonun/bloğun devam etmesi için gerekli koşulu kontrol et.
        router.showScreen(.push){ _ in
            SpotifyPlaylistView(product: product, user: user)
        }
    }
    
    
    private var header: some View{
        //MARK: HEADER
        ZStack{
            Text(product.title)
                .font(.headline)
                .padding(.vertical, 20)
                .frame(maxWidth: .infinity)
                .background(.spotifyBlack)
                .offset(y: showHeader ? 0 : -40) //TODO: ANLAT
                .opacity(showHeader ? 1 : 0)
            
            Image(systemName: "chevron.left")
                .font(.title3)
                .padding(10)
                .background(showHeader ? Color.black.opacity(0.001) : Color.spotifyGray.opacity(0.7))
                .clipShape(Circle())
                .padding(.leading, 16) //Soldan 16px boşluk
                .frame(maxWidth: .infinity, alignment: .leading)
                .onTapGesture {
                    router.dismissScreen()
                }
        }
        .foregroundStyle(.spotifyWhite)
        .animation(.smooth(duration: 0.2), value: showHeader)
        
    }
    
}

#Preview {
    RouterView{_ in
        SpotifyPlaylistView()

    }
}
