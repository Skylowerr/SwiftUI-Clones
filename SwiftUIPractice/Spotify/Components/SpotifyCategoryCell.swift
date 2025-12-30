//
//  SpotifyCategoryCell.swift
//  SwiftUIPractice
//
//  Created by Emirhan Gökçe on 16.11.2025.
//

import SwiftUI

struct SpotifyCategoryCell: View {
    var title : String = "Music"
    var isSelected : Bool = false
    var body: some View {
        Text(title) //Bu durumda, themeColors metodu içindeki self, Text("Müzik") view'ini temsil eder.
            .font(.callout)
            .frame(minWidth: 35)
            .padding(.vertical, 8)
            .padding(.horizontal, 10)
            .themeColors(isSelected: isSelected)
            .clipShape(RoundedRectangle(cornerRadius: 16))
    }
}

extension View{ //.padding, .clipshape gibi bir view oluşturduk. (.themeColors)
    //tüm modifierlar some View döndürüyor. .clipShape in üzerine gelip bakabilirsin
    func themeColors(isSelected: Bool) -> some View{
        //MARK: Swift'te, bir extension içinde bir metot tanımladığınızda, self o metodun çağrıldığı örneğin (instance) kendisine atıfta bulunur. View protokolünün bir uzantısı içinde, self o anki View'i temsil eder.
        //Mantıklı olm. .foregroundStyle() diyemezsin dümdüz. Self diyerek aslında buraya yazacağın view'ın içini değiştiriyorsun
        self
            .foregroundStyle(isSelected ? .spotifyBlack : .spotifyWhite)
            .background(isSelected ? .spotifyGreen : .spotifyDarkGray)
    }
}

#Preview {
    ZStack{
        Color.black.ignoresSafeArea()
        SpotifyCategoryCell()
        VStack(spacing: 40){
            SpotifyCategoryCell(title: "Title goes here" , isSelected: true)
            SpotifyCategoryCell(title : "Title goes here", isSelected: false)
            SpotifyCategoryCell(isSelected : false)
        }
    }
}
