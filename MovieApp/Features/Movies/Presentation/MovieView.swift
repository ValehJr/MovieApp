//
//  MovieView.swift
//  MovieApp
//
//  Created by Valeh Ismayilov on 04.01.26.
//

import SwiftUI

struct MovieView: View {
    var movie: Movie
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
}

#Preview {
    MovieView(movie: .init(id: 1, title: "Test", releaseDate: "test", backdropPath: "test", overview: "test", posterPath: "test"))
}
