//
//  ContentView.swift
//  MovieApp
//
//  Created by Valeh Ismayilov on 04.01.26.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var vm: HomeViewModel
    
    init(vm: HomeViewModel) {
        _vm = StateObject(wrappedValue: vm)
    }
    
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
                
                modeSelectionView
                    .padding(.horizontal,24)
                    .padding(.top,16)
                
                seletedModeMovies
                    .padding(24)
                
            }
            .frame(maxWidth: .infinity,alignment: .leading)
        }
        .task {
            await vm.loadTopRatedMovies()
            await vm.load()
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
                        .task {
                            await vm.loadNextPage(movie)
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
        ScrollView(.vertical,showsIndicators: false) {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 100), spacing: 16)],
                      spacing: 30
            ) {
                ForEach(vm.currentMovies) { movie in
                    MovieView(movie: movie)
                        .task {
                            guard movie == vm.currentMovies.last,
                                  !vm.isLoading
                            else { return }
                            
                            await vm.loadNextPage()
                        }
                }
            }
        }
        .id(vm.movieMode)
    }
}

#Preview {
    let container = DIContainer()
    HomeView(vm: container.makeHomeViewModel())
}
