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

    private var topRatedPage = 1
    private var canLoadMore = true
    
    private let repository: MovieRepository
    
    init(repository: MovieRepository) {
        self.repository = repository
    }
    
    func loadNextPage(_ currentItem: Movie?) async {
        guard let currentItem else {
            await loadNextPage()
            return
        }
        
        let thresholdIndex = movies.index(movies.endIndex, offsetBy: -5)
        if movies.firstIndex(where: { $0.id == currentItem.id }) == thresholdIndex {
            await loadNextPage()
        }
    }
    
    private func loadNextPage() async {
        guard canLoadMore, !isLoading else { return }
        isLoading = true
        defer { isLoading = false }
        
        do {
            let newTopRatedMovies = try await repository.fetchTopRatedMovies(page: topRatedPage + 1)
            
            if newTopRatedMovies.isEmpty {
                canLoadMore = false
            } else {
                movies.append(contentsOf: newTopRatedMovies)
                topRatedPage += 1
            }
        } catch {
            canLoadMore = false
        }
    }
    
    func load() async {
        isLoading = true
        error = nil
        
        do {
            movies = try await repository.fetchTopRatedMovies(page: topRatedPage)
        } catch {
            self.error = error.localizedDescription
            print("Failed to fetch top rated movies: \(error)")
        }
        
        isLoading = false
    }
    
}
