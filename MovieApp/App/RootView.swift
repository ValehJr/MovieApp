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
            VStack(spacing: 0) {
                content
                if path.isEmpty {
                    CustomTabBar(selectedTab: $selectedTab)
                        .transition(.move(edge: .bottom).combined(with: .opacity))
                }
            }
            .animation(.easeInOut, value: path.count)
            .navigationDestination(for: Movie.self) { movie in
                let detailsVM = container.makeMovieDetailsViewModel(movieID: movie.id)
                MovieDetailsView(vm: detailsVM)
            }
        }
    }
    
    @ViewBuilder
    private var content: some View {
        switch selectedTab {
        case .home:
            HomeView(vm: container.makeHomeViewModel())
        case .wathclist:
            WatchlistView()
        }
    }
}
