//
//  PlaylistDescriptionCell.swift
//  SwiftUIPractice
//
//  Created by Emirhan Gökçe on 17.11.2025.
//

import SwiftUI

struct PlaylistDescriptionCell: View {
    var descriptionText : String = Product.mock.description
    var userName : String = "Skylowerr"
    var subheadline: String = "Some headline goes here"
    
    var onAddToPlaylistPressed : (() -> Void)? = nil
    var onDownloadPressed : (() -> Void)? = nil
    var onASharePressed : (() -> Void)? = nil
    var onEllipsisPressed : (() -> Void)? = nil
    var onShufflePressed : (() -> Void)? = nil
    var onPlayPressed : (() -> Void)? = nil
    
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8){
            Text(descriptionText)
                .foregroundStyle(.spotifyLightGray)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            madeForYouView
            
            Text(subheadline)
            
            buttonsRow
            
            
        }
        .font(.callout)
        .fontWeight(.medium)
        .foregroundStyle(.spotifyLightGray)
    }
    
    private var madeForYouView : some View{
        HStack(spacing: 8){
            Image(systemName: "applelogo")
                .font(.title3)
                .foregroundStyle(.spotifyGreen)
            
            Text("Made for ")
            +
            Text(userName)
                .fontWeight(.bold)
                .foregroundStyle(.spotifyWhite)
        }
    }
    private var buttonsRow: some View{
        HStack(spacing: 0){
            HStack(spacing: 0){//soldakiler için
                Image(systemName: "plus.circle")
                    .padding(8) //padding koyarak tıklanabilir alanı büyültüyoruz
//                        .background(Color.red)
                    .background(Color.black.opacity(0.001)) //MARK: Eğer bu arka planı vermezseniz, sadece padding eklemek tıklanabilir alanı görsel olarak genişletir, ancak dokunma testini (hit testing) genişletmez.
                    .onTapGesture {
                        //
                    }
                
                Image(systemName: "arrow.down.circle")
                    .padding(8)
                    .background(Color.black.opacity(0.001))
                    .onTapGesture {
                        //
                    }
                
                Image(systemName: "square.and.arrow.up")
                    .padding(8)
                    .background(Color.black.opacity(0.001))
                    .onTapGesture {
                        //
                    }
                
                Image(systemName: "ellipsis")
                    .padding(8)
                    .background(Color.black.opacity(0.001))
                    .onTapGesture {
                        //
                    }
            }
            .offset(x: -8)
            .frame(maxWidth: .infinity, alignment: .leading) //MARK: Spacerla ayırabildiğimiz gibi maxWidth vererek de ayırabiliriz.
        
            HStack(spacing: 8){
                Image(systemName: "shuffle")
                    .font(.system(size: 24)) //yeteri kadar büyük old. için padding koymadık
                    .background(Color.black.opacity(0.001))
                    .onTapGesture {
                        //
                    }

                Image(systemName: "play.circle.fill")
                    .font(.system(size: 46))
                    .background(Color.black.opacity(0.001))
                    .onTapGesture {
                        //
                    }
            }
            .foregroundStyle(.spotifyGreen)
        }
        .font(.title2)


    }
}

#Preview {
    ZStack{
        Color.black.ignoresSafeArea()
        PlaylistDescriptionCell()
            .padding()
    }
}
