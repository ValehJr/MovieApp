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
    @Published private(set) var isLoading = false
    @Published private(set) var error: String?
    @Published private var states: [MovieMode: CategoryState] = [:]
    @Published var movieMode: MovieMode = .nowPlaying {
        didSet {
            Task { await loadMovies() }
        }
    }
    
    var currentMovies: [Movie] {
        states[movieMode]?.movies ?? []
    }
    
    private var topRatedPage = 1
    private var canLoadMore = true
    
    private let repository: MovieRepositoryProtocol
    
    init(repository: MovieRepositoryProtocol) {
        self.repository = repository
    }
    
    func loadTopRated(nextPage: Bool = false) async {
        guard !isLoading, canLoadMore else { return }
        
        isLoading = true
        defer { isLoading = false }
        
        let page = nextPage ? topRatedPage + 1 : 1
        
        do {
            let movies = try await repository.fetchTopRatedMovies(page: page)
            
            if page == 1 {
                topRatedMovies = movies
            } else {
                topRatedMovies.append(contentsOf: movies)
            }
            
            canLoadMore = movies.count > 0
            topRatedPage = page
        } catch {
            self.error = error.localizedDescription
        }
    }
    
    private func fetch(for mode: MovieMode, page: Int) async throws -> [Movie] {
        switch mode {
        case .nowPlaying:
            return try await repository.fetchNowPlayingMovies(page: page)
        case .popular:
            return try await repository.fetchPopularMovies(page: page)
        case .upcoming:
            return try await repository.fetchUpcomingMovies(page: page)
        case .topRated:
            return try await repository.fetchTopRatedMovies(page: page)
        }
    }
    
    func loadMovies(nextPage: Bool = false) async {
        guard let currentState = states[movieMode] else {
            states[movieMode] = CategoryState()
            await loadMovies(nextPage: false)
            return
        }
        
        guard !currentState.isLoading, currentState.canLoadMore else { return }
        
        states[movieMode]?.isLoading = true
        states[movieMode]?.error = nil
        
        let page = nextPage ? currentState.page + 1 : 1
        
        do {
            let newMovies: [Movie] = try await fetch(for: movieMode, page: page)
            
            if newMovies.isEmpty {
                states[movieMode]?.canLoadMore = false
            } else {
                if nextPage {
                    let existingIds = Set(currentState.movies.map { $0.id })
                    let filteredNewMovies = newMovies.filter { !existingIds.contains($0.id) }
                    
                    states[movieMode]?.movies.append(contentsOf: filteredNewMovies)
                    states[movieMode]?.page = page
                } else {
                    states[movieMode]?.movies = newMovies
                    states[movieMode]?.page = 1
                }
            }
        } catch {
            states[movieMode]?.error = error.localizedDescription
        }
        
        states[movieMode]?.isLoading = false
    }
}

struct CategoryState {
    var movies: [Movie] = []
    var page: Int = 1
    var canLoadMore: Bool = true
    var isLoading: Bool = false
    var error: String?
}
