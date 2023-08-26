//
//  LibraryContentRow.swift
//  MyAlbum
//
//  Created by Ronan Mak on 22/8/2023.
//

import SwiftUI
import RealmSwift
import Kingfisher

struct LibraryContentRow: View {

    @ObservedRealmObject var libraryItem: LibraryItem

    @State private var isFilled = false

    var body: some View {
        HStack {
            KFImage.url(URL(string: libraryItem.artworkUrl100))
                .renderingMode(.original)
                .placeholder {
                    Image("placeholderImage")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                        .cornerRadius(15)
                }
                .resizable()
                .scaledToFill()
                .frame(width: 100, height: 100)
                .cornerRadius(15)
                .clipped()


            VStack(alignment: .leading) {
                Text(libraryItem.collectionName)
                    .font(.headline)
                    .foregroundColor(.primary)

                Text(libraryItem.artistName)
                    .font(.subheadline)
                    .foregroundColor(.secondary)

                Text(libraryItem.country)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            Spacer()
        }
        .padding(.vertical, 8)
    }
}
