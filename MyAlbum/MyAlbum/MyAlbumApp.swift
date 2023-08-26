//
//  MyAlbumApp.swift
//  MyAlbum
//
//  Created by Ronan Mak on 20/8/2023.
//

import SwiftUI
import UIKit



@main
struct SwiftUIAppWrapper {
    static func main() {
        MyAlbumApp.main()
    }
}

struct MyAlbumApp: App {

    var body: some Scene {
        WindowGroup {
            LandingScreen()
        }
    }
}
