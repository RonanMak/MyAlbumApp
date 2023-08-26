//
//  MyAlbumSpotifyAPI.swift
//  MyAlbum
//
//  Created by Ronan Mak on 20/8/2023.
//

import Foundation

extension MyAlbumEndpoints {

    enum SpotifyAPIEndpoint: APIEndpoint {
        case getSpotifyData

        var baseURL: URL? {
            return URL(string: "https://spotify.com")
        }

        var path: String {
            switch self {
            case .getSpotifyData:
                return "/fetch"
            }
        }

        var method: HTTPMethod {
            switch self {
            case .getSpotifyData:
                return .get
            }

        }

        var headers: [String: String]? {
            switch self {
            case .getSpotifyData:
                return ["Content-Type": "application/json"]
            }
        }

        var parameters: [String: Any]? {
            switch self {
            case .getSpotifyData:
                return nil
            }
        }
    }
}
