//
//  SwiftUIPracticeApp.swift
//  SwiftUIPractice
//
//  Created by Emirhan Gökçe on 15.11.2025.
//

import SwiftUI
import SwiftfulRouting

@main
struct SwiftUIPracticeApp: App {
    var body: some Scene {
        WindowGroup {
            RouterView{ _ in
                ContentView()

            }
        }
    }
}


// Source - https://stackoverflow.com/a
// Posted by Nick Bellucci
// Retrieved 2025-11-18, License - CC BY-SA 4.0
//MARK: SWIPE BACK EXTENSION
extension UINavigationController: UIGestureRecognizerDelegate {
    override open func viewDidLoad() {
        super.viewDidLoad()
        interactivePopGestureRecognizer?.delegate = self
    }

    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return viewControllers.count > 1
    }
}
