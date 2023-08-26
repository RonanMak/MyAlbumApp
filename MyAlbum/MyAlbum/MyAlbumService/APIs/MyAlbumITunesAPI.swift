//
//  MyAlbumITunesAPI.swift
//  MyAlbum
//
//  Created by Ronan Mak on 20/8/2023.
//

import Foundation

extension MyAlbumEndpoints {

    enum iTunesAPIEndPoint: APIEndpoint {
        case search(_ request: SearchAllRequest)
        case searchByCountry(_ request: SearchRequest)
        case searchBySong(_ request: SearchRequest)

        var baseURL: URL? {
            return URL(string: "https://itunes.apple.com")
        }

        var path: String {
            switch self {
            case .search(let request):
                let path = "/search?term=\(request.searchQuery)&limit=\(request.limit)&offset=\(request.offset)"
                return path
            case .searchByCountry(let request):
                let path = "/search?term=\(request.searchQuery)&\(request.selectedOption)=ca&limit=\(request.limit)&offset=\(request.offset)"
                return path
            case .searchBySong(let request):
                let path = "/search?term=\(request.searchQuery)&entity=\(request.selectedOption)&limit=\(request.limit)&offset=\(request.offset)"
                return path
            }
        }

        var method: HTTPMethod {
            switch self {
            case .search, .searchByCountry, .searchBySong:
                return .get
            }
        }

        var headers: [String: String]? {
            switch self {
            case .search, .searchByCountry, .searchBySong:
                return ["Content-Type": "application/json"]
            }
        }

        var parameters: [String: Any]? {
            switch self {
            case .search, .searchByCountry, .searchBySong:
                return nil
            }
        }
    }
}
