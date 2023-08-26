//
//  SearchScreenModel.swift
//  MyAlbum
//
//  Created by Ronan Mak on 20/8/2023.
//

import Foundation

// MARK: - searchAll Request

struct SearchAllRequest: Codable {
    let searchQuery: String
    let limit: Int
    let offset: Int
}

struct SearchRequest: Codable {
    let searchQuery: String
    let limit: Int
    let offset: Int
    let selectedOption: String
}

// MARK: - SearchAllResponse
struct SearchResponse: Codable {
    let resultCount: Int
    let results: [SearchResult]
}

// MARK: - Result
struct SearchResult: Codable, Identifiable, Hashable {
    let id = UUID()
    let kind: String?
    let artistID: Int?
    let artistName: String?
    let collectionName: String?
    let artistViewURL: String?
    let collectionViewURL: String?
    let artworkUrl60: String?
    let artworkUrl100: String?
    let releaseDate: String?
    let country: String?

    enum CodingKeys: String, CodingKey {
        case kind
        case artistID = "artistId"
        case artistName
        case collectionName
        case artistViewURL = "artistViewUrl"
        case collectionViewURL = "collectionViewUrl"
        case artworkUrl60
        case artworkUrl100
        case releaseDate
        case country
    }
}
