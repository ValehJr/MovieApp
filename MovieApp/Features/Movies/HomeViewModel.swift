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
    @Published var topRatedMovies: [Movie] = []
    @Published var movies: [Movie] = []
    @Published private(set) var isLoading = false
    @Published private(set) var error: String?
    @Published var movieMode: MovieMode = .nowPlaying {
        didSet {
            Task {
                await load()
            }
        }
    }

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
        
        let thresholdIndex = topRatedMovies.index(topRatedMovies.endIndex, offsetBy: -5)
        if topRatedMovies.firstIndex(where: { $0.id == currentItem.id }) == thresholdIndex {
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
                topRatedMovies.append(contentsOf: newTopRatedMovies)
                topRatedPage += 1
            }
        } catch {
            canLoadMore = false
        }
    }
    
    func loadTopRatedMovies() async {
        isLoading = true
        error = nil
        
        do {
            topRatedMovies = try await repository.fetchTopRatedMovies(page: topRatedPage)
        } catch {
            self.error = error.localizedDescription
            print("Failed to fetch top rated movies: \(error)")
        }
        
        isLoading = false
    }
    
    func load() async {
        isLoading = true
        error = nil
        movies.removeAll()
        
        do {
            switch movieMode {
            case .nowPlaying:
                movies = try await repository.fetchNowPlayingMovies(page: 1)
            case .popular:
                movies = try await repository.fetchPopularMovies(page: 1)
            case .topRated:
                movies = topRatedMovies
            case .upcoming:
                movies = try await repository.fetchUpcomingMovies(page: 1)
            }
        } catch {
            self.error = error.localizedDescription
            print("Failed to fetch movies: \(error)")
        }
    }
    
}
