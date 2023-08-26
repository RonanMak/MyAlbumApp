//
//  UserSettings.swift
//  MyAlbum
//
//  Created by Ronan Mak on 22/8/2023.
//

import Foundation
import Combine
import SwiftUI


class LanguageSettings: ObservableObject {
    @Published var currentLanguage: Language = .English

    var languageResponse: LanguageResponse?
    var languageCancelable: AnyCancellable? = nil

    init() {
        binding()
    }

    func binding() {
        languageCancelable = $currentLanguage
            .sink { [weak self] language in
                self?.fetchLanguage(language)
            }
    }

    // Mock outbound call
    func fetchLanguage(_ language: Language) {
        print("language", "Language_\(language.description)")
        do {
            let languageData: LanguageResponse = try JSONUtility.decode(type: LanguageResponse.self, data: Data(contentsOf: Bundle.main.url(forResource: "Language_\(language.description)", withExtension: "json")!))
            print(languageData)
            languageResponse = languageData
        } catch {
            print(error)
        }
    }
}

enum Language {
    case Chinese
    case English

    var description: String {
            switch self {
            case .Chinese:
                return "HK"
            case .English:
                return "EN"
            }
        }
}

struct LanguageResponse: Codable {
    let searchPlaceholder: String
    let YourLibraryTitle: String
    let SearchTitle: String
    let SettingTitle: String
}
