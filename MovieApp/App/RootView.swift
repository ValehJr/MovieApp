//
//  RootView.swift
//  MovieApp
//
//  Created by Valeh Ismayilov on 13.01.26.
//

import SwiftUI

struct RootView: View {
    let container: DIContainer
    @State private var path = NavigationPath()
    @Binding var selectedTab: TabItems
    
    var body: some View {
        NavigationStack(path: $path) {
            ZStack(alignment: .bottom) {
                content
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                if path.isEmpty {
                    CustomTabBar(selectedTab: $selectedTab)
                        .transition(.move(edge: .bottom))
                }
            }
            .animation(.easeInOut, value: path.count)
            .navigationDestination(for: Movie.self) { movie in
                MovieDetailsView(
                    vm: container.makeMovieDetailsViewModel(movieID: movie.id)
                )
            }
            .navigationDestination(for: MovieDetailsEntity.self) { savedMovie in
                WatchlistDetailsView(
                    vm: container.makeWathchlistDetailsViewModel(movieID: savedMovie.id)
                )
            }
        }
        .background(.skyCaptain)
    }
    
    @ViewBuilder
    private var content: some View {
        switch selectedTab {
        case .home:
            HomeView(vm: container.makeHomeViewModel())
        case .wathclist:
            WatchlistView(vm: container.makeWathchlistViewModel())
        }
    }
}

#Preview {
    RootView(
        container: DIContainer(),
        selectedTab: .constant(.home)
    )
}

