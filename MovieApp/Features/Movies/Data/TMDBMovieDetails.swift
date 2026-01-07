//
//  TMDBMovieDetails.swift
//  MovieApp
//
//  Created by Valeh Ismayilov on 07.01.26.
//

import Foundation

final class TMDBMovieDetails: MovieDetailsProtocol {
    private let client: NetworkClient

    init(client: NetworkClient) {
        self.client = client
    }
    
    func fetchMovieDetails(id: Int) async throws -> MovieDetails {
        let response: MovieDetailsDTO = try await client.request(
            .movieDetails(id: id)
        )
        return response.toDomain()
    }
    
    func fetchMovieCredits(id: Int) async throws -> [MovieCast] {
        let response: MovieListCast = try await client.request(
            .movieCredits(id: id)
        )
        return response.cast.map { $0.toDomain() }
    }
    
    func fetchMovieReviews(id: Int) async throws -> [MovieReviews] {
        let response: MovieListReviews = try await client.request(
            .movieReviews(id: id)
        )
        return response.results.map { $0.toDomain() }
    }
}
