//
//  SettingScreen.swift
//  MyAlbum
//
//  Created by Ronan Mak on 20/8/2023.
//

import SwiftUI

struct SettingScreen: View {

    @AppStorage("language")
    private var language = LocalizationService.shared.language

    var body: some View {
        VStack(spacing: 20) {
            Text("SettingTitle".localized(language))

            Button {
                LocalizationService.shared.language = .Chinese
            } label: {
                Text("中文")
            }

            Button {
                LocalizationService.shared.language = .English
            } label: {
                Text("English")
            }

        }
    }
}
