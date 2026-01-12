//
//  DIContainer.swift
//  MovieApp
//
//  Created by Valeh Ismayilov on 05.01.26.
//

import Foundation
import SwiftData

final class DIContainer {
    lazy var networkClient: NetworkClient = {
        URLSessionNetworkClient()
    }()
    
    lazy var modelContainer: ModelContainer = {
        do {
            return try ModelContainer(for: MovieDetailsEntity.self)
        } catch {
            fatalError("Could not initialize SwiftData container: \(error)")
        }
    }()
    
    @MainActor
    lazy var persistenceService: PersistenceService = {
        PersistenceService(container: modelContainer)
    }()
    
    lazy var movieRepository: MovieRepositoryProtocol = {
        TMDBMovieRepository(client: networkClient)
    }()
    
    lazy var movieDetailsRepository: MovieDetailsProtocol = {
        TMDBMovieDetails(client: networkClient)
    }()
    
    // MARK: - ViewModels
    func makeHomeViewModel() -> HomeViewModel {
        HomeViewModel(repository: movieRepository)
    }
    
    func makeMovieDetailsViewModel(movieID: Int) -> MovieDetailsViewModel {
        MovieDetailsViewModel(movieID: movieID,repository: movieDetailsRepository,persistence: persistenceService)
    }
}
