//
//  DIContainer.swift
//  MovieApp
//
//  Created by Valeh Ismayilov on 05.01.26.
//

import Foundation

final class DIContainer {
    lazy var networkClient: NetworkClient = {
        URLSessionNetworkClient()
    }()

    lazy var movieRepository: MovieRepositoryProtocol = {
        TMDBMovieRepository(client: networkClient)
    }()

    // MARK: - ViewModels
    func makeHomeViewModel() -> HomeViewModel {
        HomeViewModel(repository: movieRepository)
    }
}
