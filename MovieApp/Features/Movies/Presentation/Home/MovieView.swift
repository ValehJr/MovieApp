//
//  MovieView.swift
//  MovieApp
//
//  Created by Valeh Ismayilov on 04.01.26.
//

import SwiftUI

struct MovieView: View {
    let movie: Movie

    var body: some View {
        RemoteImageView(
            path: movie.posterPath,
            contentMode: .fill
        )
        .aspectRatio(2/3, contentMode: .fit)
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }
}


#Preview {
    MovieView(movie: .init(id: 1, title: "Test", releaseDate: "test", backdropPath: "test", overview: "test", posterPath: "test"))
}
