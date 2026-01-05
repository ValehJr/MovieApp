//
//  DIContainer.swift
//  MovieApp
//
//  Created by Valeh Ismayilov on 05.01.26.
//

import Foundation

final class DIContainer {

    // MARK: - Core
    lazy var networkClient: NetworkClient = {
        URLSessionNetworkClient()
    }()

    // MARK: - Repositories
    lazy var movieRepository: MovieRepository = {
        TMDBMovieRepository(client: networkClient)
    }()

    // MARK: - ViewModels
    func makeHomeViewModel() -> HomeViewModel {
        HomeViewModel(repository: movieRepository)
    }
}
