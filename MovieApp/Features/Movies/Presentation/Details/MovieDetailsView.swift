//
//  MovieDetailsView.swift
//  MovieApp
//
//  Created by Valeh Ismayilov on 07.01.26.
//

import SwiftUI

struct MovieDetailsView: View {
    @StateObject var vm: MovieDetailsViewModel
    @Environment(\.dismiss) private var dismiss
    
    init(vm: MovieDetailsViewModel) {
        _vm = StateObject(wrappedValue: vm)
    }
    
    
    var body: some View {
        ZStack {
            Color.App.skyCaptain.ignoresSafeArea()
            VStack(alignment:.center) {
                MovieHeroHeaderView(
                    backdropPath: vm.movieDetails?.backdropPath,
                    posterPath: vm.movieDetails?.posterPath,
                    title: vm.movieDetails?.title
                )
                
                MovieMetaInfoView(
                    releaseDate: vm.movieDetails?.releaseDate,
                    runtime: vm.movieDetails?.runtime,
                    genre: vm.movieDetails?.genres?.first?.name
                )
                .padding(.horizontal,28)
                .padding(.top, 90)
                
                detailsScrollView
                    .padding(.horizontal,28)
                    .padding(.top,24)
                
                displayedInformation
                    .padding(.horizontal,28)
                    .padding(.top)
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
                        await vm.toggleFavorite()
                    }
                } label: {
                    Image(systemName: vm.isSaved ? "bookmark.fill" : "bookmark")
                        .foregroundColor(.white)
                }
                .disabled(vm.isLoading)
            }
            .sharedBackgroundVisibility(.hidden)
        }
        .toolbarBackground(.hidden, for: .navigationBar)
        .task {
            vm.refreshFavoriteStatus()
            await vm.fetchMovieDetails()
            await vm.fetchMovieCredits()
            await vm.fetchReviews()
        }
    }
    
    var detailsScrollView: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 16) {
                ForEach(vm.movieDetailTypes) { info in
                    Text("\(info.title)")
                        .scrollViewModifier(isSelected: info == vm.selectedDetail) {
                            vm.selectedDetail = info
                        }
                }
            }
        }
        .frame(alignment: .center)
    }
    
    @ViewBuilder
    var displayedInformation: some View {
        switch vm.selectedDetail {
        case .aboutMovie: overview
        case .reviews: reviews
        case .cast: cast
        }
    }
    
    var overview: some View {
        Text(vm.movieDetails?.overview ?? "")
            .appFont(name: .poppinsMedium, size: 12,foregroundColor: .white)
            .frame(maxWidth: .infinity, alignment: .center)
    }
    
    var reviews: some View {
        ScrollView(.vertical, showsIndicators: false) {
            LazyVGrid(columns: [GridItem(.flexible())],alignment: .leading) {
                if vm.movieReviews.isEmpty {
                    Text("No reviews available")
                } else {
                    ForEach(vm.movieReviews) { review in
                        MovieReviewView(review: review)
                            .onAppear {
                                if review == vm.movieReviews.last {
                                    Task {
                                        await vm.fetchReviews(nextPage: true)
                                    }
                                }
                            }
                        Rectangle()
                            .frame(height: 1)
                            .foregroundStyle(.lilacFields)
                    }
                }
            }
        }
    }
    
    var cast: some View {
        ScrollView(.vertical, showsIndicators: false) {
            LazyVGrid(columns: [GridItem(.flexible())]) {
                ForEach(vm.movieCast) { cast in
                    MovieCastView(cast: cast)
                        .padding(.vertical,8)
                }
            }
        }
    }
    
}

#Preview {
    let container = DIContainer()
    MovieDetailsView(vm: container.makeMovieDetailsViewModel(movieID: 1))
}
