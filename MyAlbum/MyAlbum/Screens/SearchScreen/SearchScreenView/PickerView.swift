//
//  PickerView.swift
//  MyAlbum
//
//  Created by Ronan Mak on 24/8/2023.
//

import SwiftUI

enum PickerOptions: String, CaseIterable {
    case all = "All"
    case country = "Country"
    case song = "Song"
}

struct PickerView: View {

    @AppStorage("language")
    private var language = LocalizationService.shared.language

    @Binding var selectedOption: PickerOptions

    var body: some View {
        Picker("Options", selection: $selectedOption) {
            ForEach(PickerOptions.allCases, id: \.self) { option in
                Text(option.rawValue.localized(language)).tag(option)
            }
        }
        .pickerStyle(SegmentedPickerStyle())
        .padding(.horizontal)
    }
}
