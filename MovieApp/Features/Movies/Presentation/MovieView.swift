//
//  MovieView.swift
//  MovieApp
//
//  Created by Valeh Ismayilov on 04.01.26.
//

import SwiftUI

struct MovieView: View {
    var movie: Movie
    
    // TMDB Base URL for images
    private let imageBaseURL = "https://image.tmdb.org/t/p/w500"
    
    var body: some View {
        AsyncImage(
            url: URL(string: "https://image.tmdb.org/t/p/w500\(movie.posterPath)"),
            transaction: Transaction(animation: .spring())
        ) { phase in
            switch phase {
            case .success(let image):
                image
                    .resizable()
                    .scaledToFill()
            case .failure:
                Color.App.midnightGrey
            case .empty:
                ProgressView()
            @unknown default:
                EmptyView()
            }
        }
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }
    
    // A simple reusable placeholder to keep your UI consistent
    private var placeholderView: some View {
        RoundedRectangle(cornerRadius: 16)
            .fill(Color.App.midnightGrey)
    }
}

#Preview {
    MovieView(movie: .init(id: 1, title: "Test", releaseDate: "test", backdropPath: "test", overview: "test", posterPath: "test"))
}
