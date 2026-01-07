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
            Task { await load() }
        }
    }
    
    var currentMovies: [Movie] {
        states[movieMode]?.movies ?? []
    }
    
    private var topRatedPage = 1
    private var canLoadMore = true
    
    private let repository: MovieRepository
    
    init(repository: MovieRepository) {
        self.repository = repository
    }
    
    func loadNextPage(_ currentItem: Movie?) async {
        guard let currentItem else {
            await loadNextPageForTopRated()
            return
        }
        
        let thresholdIndex = topRatedMovies.index(topRatedMovies.endIndex, offsetBy: -5)
        if topRatedMovies.firstIndex(where: { $0.id == currentItem.id }) == thresholdIndex {
            await loadNextPageForTopRated()
        }
    }
    
    private func loadNextPageForTopRated() async {
        guard canLoadMore, !isLoading else { return }
        isLoading = true
        defer { isLoading = false }
        
        do {
            let newTopRatedMovies = try await repository.fetchTopRatedMovies(page: topRatedPage + 1)
            
            if newTopRatedMovies.isEmpty {
                canLoadMore = false
            } else {
                let combined = topRatedMovies + newTopRatedMovies
                topRatedMovies = combined.uniqued()
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
        if states[movieMode] == nil {
            isLoading = true
            states[movieMode] = CategoryState()
            await fetchMovies(for: movieMode)
        }
        isLoading = false
    }
    
    func loadNextPage() async {
        guard !isLoading, let currentState = states[movieMode], currentState.canLoadMore else { return }
        
        isLoading = true
        defer { isLoading = false }
        await fetchMovies(for: movieMode, isNextPage: true)
    }
    
    private func fetchMovies(for mode: MovieMode, isNextPage: Bool = false) async {
        var state = states[mode] ?? CategoryState()
        let pageToFetch = isNextPage ? state.page + 1 : 1
        
        do {
            let newMovies: [Movie]
            switch mode {
            case .nowPlaying: newMovies = try await repository.fetchNowPlayingMovies(page: pageToFetch)
            case .popular:    newMovies = try await repository.fetchPopularMovies(page: pageToFetch)
            case .upcoming:   newMovies = try await repository.fetchUpcomingMovies(page: pageToFetch)
            case .topRated:   newMovies = try await repository.fetchTopRatedMovies(page: pageToFetch)
            }
            
            if newMovies.isEmpty {
                state.canLoadMore = false
            } else {
                if isNextPage {
                    let combined = state.movies + newMovies
                    state.movies = combined.uniqued()
                    state.page += 1
                } else {
                    state.movies = newMovies.uniqued()
                }
            }
            states[mode] = state
        } catch {
            self.error = error.localizedDescription
        }
    }
}

struct CategoryState {
    var movies: [Movie] = []
    var page: Int = 1
    var canLoadMore: Bool = true
}
