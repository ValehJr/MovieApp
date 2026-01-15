//
//  WatchlistView.swift
//  MovieApp
//
//  Created by Valeh Ismayilov on 13.01.26.
//

import SwiftUI

struct WatchlistView: View {
    
    @StateObject var vm: WatchlistViewModel
    
    init(vm: WatchlistViewModel) {
        _vm = StateObject(wrappedValue: vm)
    }
    
    var body: some View {
        ZStack {
            Color.skyCaptain.ignoresSafeArea(.all)
            VStack(alignment: .leading, spacing: 18) {
                title
                savedMovies
            }
            .padding(.horizontal,28)
        }
        .task {
            await vm.fetchSavedMovies()
        }
    }
    
    var title: some View {
        Text("Watchlist Movies")
            .appFont(name: .poppinsSemiBold, size: 24,foregroundColor: .white)
    }
    
    var savedMovies: some View {
        ScrollView(.vertical, showsIndicators: false) {
            LazyVGrid(columns: [GridItem(.flexible())],spacing: 24) {
                ForEach(vm.savedMovies) { movie in
                    NavigationLink(value: movie) {
                        WathclistSingleView(movie: movie)
                    }
                }
            }
        }
    }
}

#Preview {
    let container = DIContainer()
    WatchlistView(vm: container.makeWathchlistViewModel())
}
