//
//  TMDBMovieRepository.swift
//  MovieApp
//
//  Created by Valeh Ismayilov on 05.01.26.
//

import Foundation

final class TMDBMovieRepository: MovieRepository {
//    func fetchNowPlayingMovies(page: Int) async throws -> [Movie] {
//        <#code#>
//    }
//    
//    func fetchTopRatedMovies(page: Int) async throws -> [Movie] {
//        <#code#>
//    }
//    
//    func searchMovies(query: String, page: Int) async throws -> [Movie] {
//        <#code#>
//    }
    
    private let client: NetworkClient

    init(client: NetworkClient) {
        self.client = client
    }

    func fetchPopularMovies(page: Int) async throws -> [Movie] {
        let response: MovieListResponseDTO = try await client.request(
            .popularMovies(page: page)
        )
        return response.results.map { $0.toDomain() }
    }
}
