//
//  WatchlistDetailsView.swift
//  MovieApp
//
//  Created by Valeh Ismayilov on 15.01.26.
//


import SwiftUI

struct WatchlistDetailsView: View {
    
    @ObservedObject var vm: WatchlistDetailsViewModel
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        ZStack {
            Color.App.skyCaptain.ignoresSafeArea()
            VStack(alignment:.center) {
                MovieHeroHeaderView(
                    backdropPath: displayBackdrop,
                    posterPath: displayPoster,
                    title: displayTitle
                )
                
                MovieMetaInfoView(
                    releaseDate: displayReleaseDate,
                    runtime: displayRuntime,
                    genre: displayGenres
                )
                .padding(.horizontal,28)
                .padding(.top, 90)
                
                overview
                    .padding(.horizontal,28)
                    .padding(.top,24)
                
                Spacer()
            }
        }
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "chevron.left")
                        .foregroundColor(.white)
                }
            }
            .sharedBackgroundVisibility(.hidden)
            
            ToolbarItem(placement: .principal) {
                Text("Details")
                    .foregroundColor(.white)
                    .font(.headline)
            }
            
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    Task {
                        vm.toggleFavorite()
                    }
                } label: {
                    Image(systemName: vm.isSaved ? "bookmark.fill" : "bookmark")
                        .foregroundColor(.white)
                }
            }
            .sharedBackgroundVisibility(.hidden)
            
        }
        .toolbarBackground(.hidden, for: .navigationBar)
        .onAppear {
            vm.fetchMovieDetails()
        }
    }
    
    var overview: some View {
        Text(displayOverview)
            .appFont(name: .poppinsMedium, size: 12,foregroundColor: .white)
            .frame(maxWidth: .infinity, alignment: .center)
    }
    
    private var displayTitle: String {
        vm.movie?.title ?? vm.snapshot?.title ?? "N/A"
    }
    
    private var displayOverview: String {
        vm.movie?.overview ?? vm.snapshot?.overview ?? "N/A"
    }
    
    private var displayBackdrop: String? {
        vm.movie?.backdropPath ?? vm.snapshot?.backdropPath
    }
    
    private var displayPoster: String? {
        vm.movie?.posterPath ?? vm.snapshot?.posterPath
    }
    
    private var displayRuntime: Int {
        vm.movie?.runtime ?? vm.snapshot?.runtime ?? 0
    }
    
    private var displayReleaseDate: String {
        vm.movie?.releaseDate ?? vm.snapshot?.releaseDate ?? "N/A"
    }
    
    private var displayGenres: String {
        vm.movie?.genres?.name ?? vm.snapshot?.genre?.name ?? "N/A"
    }
}

#Preview {
    let container = DIContainer()
    WatchlistDetailsView(vm: container.makeWathchlistDetailsViewModel(movieID: 1))
}
