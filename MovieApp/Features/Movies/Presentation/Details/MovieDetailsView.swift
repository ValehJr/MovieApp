//
//  MovieDetailsView.swift
//  MovieApp
//
//  Created by Valeh Ismayilov on 07.01.26.
//

import SwiftUI

struct MovieDetailsView: View {
    @StateObject private var vm: MovieDetailsViewModel
    
    init(vm: MovieDetailsViewModel) {
        _vm = StateObject(wrappedValue: vm)
    }
    
    var body: some View {
        ZStack {
            Color.App.skyCaptain.ignoresSafeArea()
            VStack(alignment:.center) {
                ZStack(alignment: .bottomLeading) {
                    backdrop
                    heroContent
                        .padding(.leading,28)
                        .padding(.trailing)
                }
                
                details
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
        .task {
            await vm.fetchMovieDetails()
            await vm.fetchMovieCredits()
            await vm.fetchReviews()
        }
    }
    
    @ViewBuilder
    var backdrop: some View {
        if let path = vm.movieDetails?.backdropPath {
            RemoteImageView(
                path: path,
                contentMode: .fill
            )
            .frame(height: 210)
            .clipped()
        }

    }
    
    @ViewBuilder
    var poster: some View {
        if let path = vm.movieDetails?.posterPath {
            RemoteImageView(
                path: path,
                contentMode: .fill
            )
            .frame(width: 95,height: 120)
            .aspectRatio(2/3, contentMode: .fit)
            .clipShape(RoundedRectangle(cornerRadius: 16))
        }

    }
    
    var title: some View {
        Text(vm.movieDetails?.title ?? "")
            .appFont(name: .poppinsSemiBold, size: 24,foregroundColor: .white)
            .multilineTextAlignment(.leading)
            .frame(maxWidth: .infinity,alignment: .leading)
    }
    
    var heroContent: some View {
        HStack(spacing: 12) {
            poster
            title
        }
        .padding(.bottom, -60)
    }
    
    var details: some View {
        HStack(spacing: 12) {
            releaseDate
            rect
            runtime
            rect
            genre
        }
    }
    
    @ViewBuilder
    var releaseDate: some View {
        HStack(spacing: 4) {
            Image(.calendar)
                .resizable()
                .scaledToFit()
                .frame(width: 18,height: 18)
            
            if let releaseDate = vm.movieDetails?.releaseDate {
                Text(releaseDate.dateFormatter())
                    .appFont(name: .poppinsMedium, size: 14,foregroundColor: .lilacFields)
            }
        }
    }
    
    @ViewBuilder
    var runtime: some View {
        HStack(spacing: 4) {
            Image(.clock)
                .resizable()
                .scaledToFit()
                .frame(width: 18,height: 18)
            
            if let runtime = vm.movieDetails?.runtime {
                Text("\(runtime) minutes")
                    .appFont(name: .poppinsMedium, size: 14,foregroundColor: .lilacFields)
            }
            
        }
    }
    
    var genre: some View {
        Text(vm.movieDetails?.genres.first?.name ?? "")
            .appFont(name: .poppinsMedium, size: 14,foregroundColor: .lilacFields)
    }
    
    var rect: some View {
        Rectangle()
            .foregroundStyle(.lilacFields)
            .frame(width: 1,height: 16)
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
        case .cast: Text("Cast")
        }
    }
    
    var overview: some View {
        Text(vm.movieDetails?.overview ?? "")
            .appFont(name: .poppinsMedium, size: 12,foregroundColor: .white)
            .frame(maxWidth: .infinity, alignment: .center)
    }
    
    var reviews: some View {
        ScrollView(.vertical, showsIndicators: false) {
            LazyVGrid(columns: [GridItem(.flexible())]) {
                if vm.movieReviews.isEmpty {
                    Text("No reviews available")
                } else {
                    ForEach(vm.movieReviews) { review in
                        MovieReview(review: review)
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

    
}

#Preview {
    let container = DIContainer()
    MovieDetailsView(vm: container.makeMovieDetailsViewModel(movieID: 83533))
}
