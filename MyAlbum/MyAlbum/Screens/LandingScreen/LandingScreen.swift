//
//  LandingScreen.swift
//  MyAlbum
//
//  Created by Ronan Mak on 20/8/2023.
//

import SwiftUI

struct LandingScreen: View {

    @AppStorage("language")
    private var language = LocalizationService.shared.language

    var body: some View {
        TabView {
            SettingScreen()
                .tabItem {
                    Image(systemName: "house.circle")
                    Text("HomeTabTitle".localized(language))
                }

            SearchScreen()
                .tabItem {
                    Image(systemName: "magnifyingglass.circle")
                    Text("SearchTabTitle".localized(language))
                }

            LibraryScreen()
                .tabItem {
                    Image(systemName: "building.columns.circle")
                    Text("LibraryTabTitle".localized(language))
                }
        }
    }
}
