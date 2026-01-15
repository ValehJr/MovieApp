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
                    backdropPath: vm.movie?.backdropPath,
                    posterPath: vm.movie?.posterPath,
                    title: vm.movie?.title
                )
                
                MovieMetaInfoView(
                    releaseDate: vm.movie?.releaseDate,
                    runtime: vm.movie?.runtime,
                    genre: vm.movie?.genres?.name
                )
                .padding(.horizontal,28)
                .padding(.top, 90)
                
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
                        
                    }
                } label: {

                }
            }
            .sharedBackgroundVisibility(.hidden)

        }
        .toolbarBackground(.hidden, for: .navigationBar)
        .onAppear {
            vm.fetchMovieDetails()
        }
    }
}

#Preview {
    let container = DIContainer()
    WatchlistDetailsView(vm: container.makeWathchlistDetailsViewModel(movieID: 1))
}
