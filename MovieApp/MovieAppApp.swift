//
//  MovieAppApp.swift
//  MovieApp
//
//  Created by Valeh Ismayilov on 04.01.26.
//

import SwiftUI

@main
struct MovieAppApp: App {
    // 1. Initialize the Data Layer (The Repository)
    // Using a 'let' here ensures it's created once for the app's lifetime
    let movieRepository = MovieRepository()
    
    var body: some Scene {
        WindowGroup {
            // 2. Initialize the Domain Layer (Use Cases)
            let searchUseCase = SearchMoviesUseCase(repository: movieRepository)
            let popularUseCase = GetPopularMoviesUseCase(repository: movieRepository)
            let topRatedUseCase = GetTopRatedMoviesUseCase(repository: movieRepository)
            let nowPlayingUseCase = GetNowPlayingMoviesUsecase(repository: movieRepository)
            
            // 3. Initialize the Presentation Layer (ViewModel)
            let viewModel = HomeViewModel(
                searchUseCase: searchUseCase,
                popularUseCase: popularUseCase,
                topRatedUseCase: topRatedUseCase,
                nowPlayingUseCase: nowPlayingUseCase
            )
            
            // 4. Inject the ViewModel into the View
            HomeView(vm: viewModel)
        }
    }
}
