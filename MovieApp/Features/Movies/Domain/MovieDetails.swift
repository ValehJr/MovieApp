//
//  MovieDetails.swift
//  MovieApp
//
//  Created by Valeh Ismayilov on 07.01.26.
//

struct MovieDetails: Identifiable {
    let id: Int
    let overview: String
    let title: String
    let runtime: Int
    let releaseDate: String
    let backdropPath: String
    let posterPath: String
    let genres: [MovieGenre]
}

struct MovieGenre: Identifiable {
    let id: Int
    let name: String
}
