//
//  WatchlistDetailsViewModel.swift
//  MovieApp
//
//  Created by Valeh Ismayilov on 15.01.26.
//

import Foundation
import Combine

@MainActor
class WatchlistDetailsViewModel: ObservableObject {
    
    @Published var movie: MovieDetailsEntity?
    private let id: Int
    @Published private(set) var error: String?
    private let persistence: PersistenceService
    
    init(persistence: PersistenceService,id: Int) {
        self.persistence = persistence
        self.id = id
    }
    
    func fetchMovieDetails() {
        movie = persistence.fetchMovie(id: id)
    }
}
