//
//  ContentView.swift
//  SwiftUIPractice
//
//  Created by Emirhan Gökçe on 15.11.2025.
//

import SwiftUI
import SwiftfulUI
import SwiftfulRouting

struct ContentView: View {
    
    @Environment(\.router) var router

    var body: some View {
        List{
            Button("Open Spotify"){
                router.showScreen(.fullScreenCover){_ in
                    SpotifyHomeView()
                }
            }
            
            Button("Open Bumble"){
                router.showScreen(.fullScreenCover){_ in
                    BumbleHomeView()
                }
            }
            
        }

    }
    

}

#Preview {
    RouterView{ _ in
        ContentView()
        
    }
}
