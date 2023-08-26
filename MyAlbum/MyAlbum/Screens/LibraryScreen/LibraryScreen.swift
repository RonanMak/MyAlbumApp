//
//  LibraryScreen.swift
//  MyAlbum
//
//  Created by Ronan Mak on 22/8/2023.
//

import SwiftUI
import RealmSwift

struct LibraryScreen: View {

    @AppStorage("language")
    private var language = LocalizationService.shared.language
    
    @ObservedResults(LibraryItem.self) var albumItems

    var body: some View {
        VStack {
            Text("YourLibraryTitle".localized(language))
                .font(.headline)
                .foregroundColor(.primary)
                .padding(10)

            List {
                ForEach(albumItems) { albumItem in
                    LibraryContentRow(libraryItem: albumItem)
                }
                .onDelete(perform: delete)
                .listStyle(GroupedListStyle())
            }
        }
    }

    private func delete(at offsets: IndexSet) {
        for index in offsets {
            let albumItem = albumItems[index]
            RealmManager.shared.delete(ofType: LibraryItem.self, with: albumItem.id)
        }
    }
}
