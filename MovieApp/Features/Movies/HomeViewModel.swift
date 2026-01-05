//
//  HomeViewModel.swift
//  MovieApp
//
//  Created by Valeh Ismayilov on 04.01.26.
//

import Foundation
import Combine

@MainActor
class HomeViewModel: ObservableObject {
    @Published var searchText: String = ""
    @Published var movies: [Movie] = []
    @Published private(set) var isLoading = false
    @Published private(set) var error: String?
    
    private let repository: MovieRepository
    
    init(repository: MovieRepository) {
        self.repository = repository
    }
    
    func load() async {
        isLoading = true
        error = nil
        
        do {
            movies = try await repository.fetchPopularMovies(page: 1)
        } catch {
            self.error = error.localizedDescription
            print("Failed to fetch top rated movies: \(error)")
        }
        
        isLoading = false
    }
    
}
