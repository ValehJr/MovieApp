//
//  MovieRepository.swift
//  MovieApp
//
//  Created by Valeh Ismayilov on 04.01.26.
//

import Foundation

final class MovieRepository: MovieRepositoryProtocol {
    
    private let session = URLSession.shared

    func fetchPopularMovies(page: Int) async throws -> [Movie] {
        let urlString = "\(APIConfig.baseURL)/movie/popular?api_key=\(APIConfig.apiKey)&page=\(page)"
        return try await performRequest(with: urlString)
    }

    func searchMovies(query: String, page: Int) async throws -> [Movie] {
        let encodedQuery = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        let urlString = "\(APIConfig.baseURL)/search/movie?api_key=\(APIConfig.apiKey)&query=\(encodedQuery)&page=\(page)"
        return try await performRequest(with: urlString)
    }

    private func performRequest(with urlString: String) async throws -> [Movie] {
        guard let url = URL(string: urlString) else { throw URLError(.badURL) }
        
        let (data, _) = try await session.data(from: url)
        let response = try JSONDecoder().decode(MoviesResponseDTO.self, from: data)
        
        return response.results.map { $0.toEntity() }
    }
}
