//
//  SearchMoviesUseCase.swift
//  MovieApp
//
//  Created by Valeh Ismayilov on 04.01.26.
//

import Foundation

final class SearchMoviesUseCase {
    private let repository: MovieRepositoryProtocol
    
    init(repository: MovieRepositoryProtocol) {
        self.repository = repository
    }
    func execute(query: String, page: Int) async throws -> [Movie] {
        let movies = try await repository.searchMovies(query: query, page: page)
        return movies
    }
}
