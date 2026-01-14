//
//  WathclistViewModel.swift
//  MovieApp
//
//  Created by Valeh Ismayilov on 14.01.26.
//

import Foundation
import Combine


@MainActor
class WatchlistViewModel: ObservableObject {
    
    @Published var savedMovies: [MovieDetailsEntity] = []
    
    private let persistence: PersistenceService
    
    init(
        persistence: PersistenceService
    ) {
        self.persistence = persistence
    }
    
    func fetchSavedMovies() async{
        if let savedMovies = try? await persistence.fetchAllMovies() {
            self.savedMovies = savedMovies
        }
    }
}
