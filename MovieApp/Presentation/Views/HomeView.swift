//
//  ContentView.swift
//  MovieApp
//
//  Created by Valeh Ismayilov on 04.01.26.
//

import SwiftUI

struct HomeView: View {
    @StateObject var vm: HomeViewModel
    var body: some View {
        ZStack {
            Color.App.skyCaptain.ignoresSafeArea()
            
            VStack(alignment:.leading,spacing: 0) {
                title
                    .padding([.top,.leading],24)
                
                searchBar
                    .padding(24)
                
                topRatedTitle
                    .padding(.leading,24)
                
                topRatedMovies
                    .padding(24)
                
                Spacer()
            }
            .frame(maxWidth: .infinity,alignment: .leading)
        }
        .task {
            await vm.fetchTopRatedMovies()
        }
        
    }
    
    var title: some View {
        Text("What do you want to watch?")
            .appFont(name: .poppinsSemiBold, size: 18,foregroundColor: .white)
    }
    
    var searchBar: some View {
        SearchField(text: $vm.searchText)
    }
    
    var topRatedTitle: some View {
        Text("Top Rated")
            .appFont(name: .poppinsSemiBold, size: 18,foregroundColor: .white)
    }
    
    var topRatedMovies: some View {
        ScrollView(.horizontal,showsIndicators: false) {
            LazyHGrid(rows: [GridItem(.flexible())],spacing: 30) {
                ForEach(vm.topRatedMovies) { movie in
                    MovieView(movie: movie)
                }
            }
        }
        .frame(height: 144)
    }
}

#Preview {
    let repo = MovieRepository()
    
    let search = SearchMoviesUseCase(repository: repo)
    let popular = GetPopularMoviesUseCase(repository: repo)
    let topRated = GetTopRatedMoviesUseCase(repository: repo)
    let nowPlaying = GetNowPlayingMoviesUsecase(repository: repo)
    
    let vm = HomeViewModel(
        searchUseCase: search,
        popularUseCase: popular,
        topRatedUseCase: topRated,
        nowPlayingUseCase: nowPlaying
    )
    
    return HomeView(vm: vm)
}
