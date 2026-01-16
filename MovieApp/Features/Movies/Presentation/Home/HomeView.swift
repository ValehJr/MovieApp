//
//  ContentView.swift
//  MovieApp
//
//  Created by Valeh Ismayilov on 04.01.26.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var vm: HomeViewModel
    @FocusState private var isSearchBarFocused: Bool
    
    init(vm: HomeViewModel) {
        _vm = StateObject(wrappedValue: vm)
    }
    
    var body: some View {
        ZStack {
            Color.App.skyCaptain.ignoresSafeArea()
            
            VStack(alignment: .leading, spacing: 0) {
                title
                    .padding([.top, .leading], 24)
                
                searchBar
                    .padding(24)
                
                if isSearchBarFocused || !vm.searchText.isEmpty {
                    searchResults
                        .padding(.bottom,64)
                        .transition(.opacity)
                } else {
                    mainContent
                        .transition(.opacity)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .animation(.easeInOut, value: isSearchBarFocused)
        .task {
            await vm.loadTopRated()
            await vm.loadMovies()
        }
        .onTapGesture {
            isSearchBarFocused = false
        }
    }
    
    var mainContent: some View {
        Group {
            topRatedTitle
                .padding(.leading, 24)
            
            topRatedMovies
                .padding(24)
            
            modeSelectionView
                .padding(.horizontal, 24)
                .padding(.top, 16)
            
            seletedModeMovies
                .padding(.horizontal, 20)
                .padding(.bottom,64)
        }
    }
    
    var title: some View {
        Text("What do you want to watch?")
            .appFont(name: .poppinsSemiBold, size: 20,foregroundColor: .white)
    }
    
    var searchBar: some View {
        SearchField(text: $vm.searchText)
            .focused($isSearchBarFocused)
            .onChange(of: vm.searchText) {
                vm.movieSearch(vm.searchText)
            }
    }
    
    var topRatedTitle: some View {
        Text("Top Rated")
            .appFont(name: .poppinsSemiBold, size: 18,foregroundColor: .white)
    }
    
    var topRatedMovies: some View {
        ScrollView(.horizontal,showsIndicators: false) {
            LazyHGrid(rows: [GridItem(.flexible())],spacing: 30) {
                ForEach(vm.topRatedMovies) { movie in
                    NavigationLink(value: movie.id) {
                        MovieView(moviePosterPath: movie.posterPath)
                            .onAppear {
                                if movie == vm.topRatedMovies.last {
                                    Task {
                                        await vm.loadTopRated(nextPage: true)
                                    }
                                }
                            }
                    }
                }
            }
        }
        .frame(height: 210)
    }
    
    var modeSelectionView: some View {
        ModeSelectionView(selectedMode: $vm.movieMode)
    }
    
    var seletedModeMovies: some View {
        ScrollView(.vertical, showsIndicators: false) {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 90), spacing: 16)], spacing: 30) {
                ForEach(vm.currentMovies) { movie in
                    NavigationLink(value: movie.id) {
                        MovieView(moviePosterPath: movie.posterPath)
                            .onAppear {
                                if movie == vm.currentMovies.last {
                                    Task {
                                        await vm.loadMovies(nextPage: true)
                                    }
                                }
                            }
                    }
                }
            }
            .padding()
        }
        .id(vm.movieMode)
        .background(Color.skyCaptain)
    }
    
    var searchResults: some View {
        ScrollView(.vertical, showsIndicators: false) {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 90), spacing: 16)], spacing: 30) {
                ForEach(vm.searchResults) { movie in
                    NavigationLink(value: movie.id) {
                        MovieView(moviePosterPath: movie.posterPath)
                    }
                }
            }
            .padding()
        }
        .background(Color.skyCaptain)
    }
}

#Preview {
    let container = DIContainer()
    HomeView(vm: container.makeHomeViewModel())
}
