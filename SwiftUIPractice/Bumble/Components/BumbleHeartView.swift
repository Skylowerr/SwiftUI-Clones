//
//  BumbleHeartView.swift
//  SwiftUIPractice
//
//  Created by Emirhan Gökçe on 20.11.2025.
//

import SwiftUI

struct BumbleHeartView: View {
    var body: some View {
        ZStack{
            Circle()
                .fill(.bumbleYellow)
                .frame(width: 40, height: 40)
            
            Image(systemName: "bubble.fill")
                .offset(y: 2) //daha iyi ortalamak için yukarıdan 2px boşluk çekiyoruz
                .foregroundColor(.bumbleBlack)
                .font(.system(size: 22))
            
            Image(systemName: "heart.fill")
                .foregroundColor(.bumbleYellow)
                .font(.system(size: 10))
        }
    }
}

#Preview {
    BumbleHeartView()
}
