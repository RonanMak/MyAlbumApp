//
//  MyAlbumService.swift
//  MyAlbum
//
//  Created by Ronan Mak on 20/8/2023.
//

import Foundation
import Combine

enum MyAlbumEndpoints {}

protocol APIClient {
    associatedtype EndpointType: APIEndpoint
    func request<T: Decodable>(_ endpoint: EndpointType) -> AnyPublisher<T, Error>
}

protocol APIEndpoint {
    var baseURL: URL? { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var headers: [String: String]? { get }
    var parameters: [String: Any]? { get }
}

extension APIEndpoint {
    var headers: [String: String]? {
        return nil
    }

    var parameters: [String: Any]? {
        return nil
    }
}

enum APIError: Error {
    case invalidResponse
    case invalidUrl
}

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

class URLSessionAPIClient<EndpointType: APIEndpoint>: APIClient {

    func request<T: Decodable>(_ endpoint: EndpointType) -> AnyPublisher<T, Error> {
        guard let url = endpoint.baseURL.flatMap ({ URL(string: $0.absoluteString + endpoint.path)}) else {
            return Fail(error: APIError.invalidUrl)
                .eraseToAnyPublisher()
        }
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue

        // Set up any request headers or parameters here
        endpoint.headers?.forEach { request.addValue($0.value, forHTTPHeaderField: $0.key) }

        return URLSession.shared.dataTaskPublisher(for: request)
            .subscribe(on: DispatchQueue.global(qos: .background))
            .tryMap { data, response -> Data in
                guard let httpResponse = response as? HTTPURLResponse,
                      (200...299).contains(httpResponse.statusCode) else {
                    throw APIError.invalidResponse
                }
                return data
            }
            .decode(type: T.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }

}
