//
//  JSONUtility.swift
//  MyAlbum
//
//  Created by Ronan Mak on 23/8/2023.
//

import Foundation

struct JSONUtility {
    static func decode<T: Decodable>(type: T.Type, data: Data) throws -> T {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    }
}
