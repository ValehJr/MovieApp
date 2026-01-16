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
            .animation(.easeInOut, value: path.isEmpty)
            .navigationDestination(for: Int.self) { movieID in
                MovieDetailsView(
                    vm: container.makeMovieDetailsViewModel(movieID: movieID)
                )
            }
            .navigationDestination(for: MovieDetailsEntity.self) { savedMovie in
                WatchlistDetailsView(
                    vm: container.makeWathchlistDetailsViewModel(movieID: savedMovie.id)
                )
            }
            .ignoresSafeArea(.keyboard, edges: .bottom)
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

