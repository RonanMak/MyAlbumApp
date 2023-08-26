//
//  AlbumItem.swift
//  MyAlbum
//
//  Created by Ronan Mak on 22/8/2023.
//

import Foundation
import SwiftUI
import RealmSwift

// Local DB

class LibraryItem: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var id: String = UUID().uuidString

    @Persisted var collectionName: String = ""
    @Persisted var country: String = ""
    @Persisted var artistName: String = ""
    @Persisted var artworkUrl100: String = ""
    @Persisted var isliked: Bool = true
}
