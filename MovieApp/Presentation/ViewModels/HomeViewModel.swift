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
    @Published var errorMessage: String? = nil

    private let searchUseCase: SearchMoviesUseCase
    private let popularUseCase: GetPopularMoviesUseCase
    private let topRatedUseCase: GetTopRatedMoviesUseCase
    private let nowPlayingUseCase: GetNowPlayingMoviesUsecase

    init(searchUseCase: SearchMoviesUseCase, popularUseCase: GetPopularMoviesUseCase,topRatedUseCase: GetTopRatedMoviesUseCase,nowPlayingUseCase: GetNowPlayingMoviesUsecase) {
        self.searchUseCase = searchUseCase
        self.popularUseCase = popularUseCase
        self.topRatedUseCase = topRatedUseCase
        self.nowPlayingUseCase = nowPlayingUseCase
    }
    
    func fetchTopRatedMovies() async {
        do {
            self.topRatedMovies = try await self.topRatedUseCase.execute(page: 1)
            print(topRatedMovies)
        } catch {
            print("Failed to fetch top rated movies: \(error)")
        }
    }
    
}
