//
//  InterestPillGridView.swift
//  SwiftUIPractice
//
//  Created by Emirhan Gökçe on 20.11.2025.
//

import SwiftUI
import SwiftfulUI

struct UserInterest: Identifiable {
    let id = UUID().uuidString //nesne bir kez oluşturulduktan sonra değişmemesi istenir
    //TODO: Üstteki let iken neden alttakiler var?
    //Uygulama, kullanıcının ilgisini düzenlemesine izin veriyorsa, text alanının veya iconName alanının güncellenmesi gerekir
    var iconName : String? = nil
    var emoji : String? = nil
    var text : String
}

struct InterestPillGridView: View {
    
    var interests : [UserInterest] = User.mock.interests
    
    var body: some View {
        ZStack{
            //TODO: NonLazyVGrid ne işe yarıyor?
            NonLazyVGrid(columns: 2, alignment: .leading, spacing: 8, items: interests) { interest in
                if let interest{
                    InterestPillView(
                        iconName: interest.iconName,
                        emoji: interest.emoji,
                        text: interest.text
                    )
                }else{
                    EmptyView() //TODO: Bu ne
                }
            }
        }
    }
}

#Preview {
    VStack(spacing:40){
        InterestPillGridView(interests: User.mock.basics)
        InterestPillGridView(interests: User.mock.interests)
    }

}
