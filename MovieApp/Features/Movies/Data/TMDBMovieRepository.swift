//
//  TMDBMovieRepository.swift
//  MovieApp
//
//  Created by Valeh Ismayilov on 05.01.26.
//

import Foundation

final class TMDBMovieRepository: MovieRepositoryProtocol {
    private let client: NetworkClient

    init(client: NetworkClient) {
        self.client = client
    }
    
    func fetchNowPlayingMovies(page: Int) async throws -> [Movie] {
        let response: MovieListResponse = try await client.request(
            .nowPlayingMovies(page: page)
        )
        return (response.results ?? []).map { $0.toDomain() }
    }
    
    func fetchTopRatedMovies(page: Int) async throws -> [Movie] {
        let response: MovieListResponse = try await client.request(
            .topRatedMovies(page: page)
        )
        return (response.results ?? []).map { $0.toDomain() }
    }
    
    func fetchUpcomingMovies(page: Int) async throws -> [Movie] {
        let response: MovieListResponse = try await client.request(
            .upcomingMovies(page: page)
        )
        return (response.results ?? []).map { $0.toDomain() }
    }
    
    func fetchPopularMovies(page: Int) async throws -> [Movie] {
        let response: MovieListResponse = try await client.request(
            .popularMovies(page: page)
        )
        return (response.results ?? []).map { $0.toDomain() }
    }

    func searchMovies(query: String, page: Int) async throws -> [MovieSearch] {
        let response: MovieSearchList = try await client.request(
            .movieSearch(query: query, page: page)
        )
        return (response.results ?? []).map { $0.toDomain() }
    }
}
