//
//  MoviesResponseDTO.swift
//  MovieApp
//
//  Created by Valeh Ismayilov on 05.01.26.
//


import Foundation

struct MovieDTO: Codable {
    let id: Int
    let title: String
    let overview: String
    let posterPath: String?
    let backdropPath: String?
    let releaseDate: String?
}

extension MovieDTO {
    func toDomain() -> Movie {
        let movie =  Movie(
            id: self.id,
            title: self.title,
            releaseDate: self.releaseDate ?? "",
            backdropPath: self.backdropPath ?? "",
            overview: self.overview,
            posterPath: self.posterPath ?? ""
        )
        return movie
    }
}
