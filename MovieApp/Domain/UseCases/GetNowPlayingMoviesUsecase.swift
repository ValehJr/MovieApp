//
//  GetNowPlayingMoviesUsecase.swift
//  MovieApp
//
//  Created by Valeh Ismayilov on 04.01.26.
//

import Foundation

final class GetNowPlayingMoviesUsecase {
    
    private let repository: MovieRepositoryProtocol
    
    init(repository: MovieRepositoryProtocol) {
        self.repository = repository
    }
    
    func execute(page: Int) async throws -> [Movie] {
        let movies: [Movie] = try await repository.fetchNowPlayingMovies(page: page)
        return movies
    }
}
