//
//  MovieView.swift
//  MovieApp
//
//  Created by Valeh Ismayilov on 04.01.26.
//

import SwiftUI

struct MovieView: View {
    var movie: Movie
    @StateObject private var loader = ImageLoader()

    var body: some View {
        ZStack {
            if let image = loader.image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
                    .transition(.opacity.animation(.easeInOut))
            } else {
                ZStack {
                    Color.App.glaucophobia
                    ProgressView()
                        .tint(.skyCaptain)
                }
            }
        }
        .aspectRatio(2/3, contentMode: .fit)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .onAppear {
            loader.load(urlString: "https://image.tmdb.org/t/p/w500\(movie.posterPath)")
        }
    }
}

#Preview {
    MovieView(movie: .init(id: 1, title: "Test", releaseDate: "test", backdropPath: "test", overview: "test", posterPath: "test"))
}
