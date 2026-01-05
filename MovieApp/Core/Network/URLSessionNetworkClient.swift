//
//  URLSessionNetworkClient.swift
//  MovieApp
//
//  Created by Valeh Ismayilov on 05.01.26.
//

import Foundation

final class URLSessionNetworkClient: NetworkClient {
    private let session: URLSession

    init(session: URLSession = .shared) {
        self.session = session
    }

    func request<T: Decodable>(_ endpoint: Endpoint) async throws -> T {
        let request = try endpoint.makeRequest()
        let (data, response) = try await session.data(for: request)
        try ResponseValidator.validate(response)
        return try JSONDecoder.tmdb.decode(T.self, from: data)
    }
}
