//
//  SearchContentRow.swift
//  MyAlbum
//
//  Created by Ronan Mak on 21/8/2023.
//

import SwiftUI
import Kingfisher

struct SearchContentRow: View {

    var album: SearchResult

    var body: some View {
            HStack(alignment: .center, spacing: 15) {
                    KFImage.url(URL(string: album.artworkUrl100!))
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

                VStack(alignment: .leading, spacing: 8, content: {
                    Group {
                        Text(album.collectionName ?? "")
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundColor(.black)
                            .fontWeight(.bold)
                            .lineLimit(2)
                        Text("\(album.artistName ?? "") - \(album.kind ?? "")")
                    }
                    .font(.system(size: 14))
                    .foregroundColor(.gray)
                    .lineLimit(1)
                    .multilineTextAlignment(.leading)
                })
                .padding(.vertical)
                Spacer(minLength: 0)

                likeButtonView { isLiked in
                    updateAlbumInDatabase(isLiked)
                }
            }
            .padding(.horizontal)
    }
}

extension SearchContentRow {
    func updateAlbumInDatabase(_ isLiked: Bool) {
        let albumItem = LibraryItem()
        albumItem.id = album.id.uuidString
        albumItem.collectionName = album.collectionName ?? ""
        albumItem.country = album.country ?? ""
        albumItem.artistName = album.artistName ?? ""
        albumItem.artworkUrl100 = album.artworkUrl100 ?? ""
        albumItem.isliked = true

        isLiked ?
        RealmManager.shared.add(albumItem) :
        RealmManager.shared.delete(ofType: LibraryItem.self, with: album.id.uuidString)
    }

}
