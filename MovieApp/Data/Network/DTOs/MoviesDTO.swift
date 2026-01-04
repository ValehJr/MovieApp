//
//  PopularMoviesDTO.swift
//  MovieApp
//
//  Created by Valeh Ismayilov on 04.01.26.
//

import Foundation

struct MoviesResponseDTO: Codable {
    var page: Int
    var results: [MoviesDTO]
}

struct MoviesDTO: Identifiable, Codable {
    let id: Int
    let title: String
    let releaseDate: String
    let overview: String
    let posterPath: String?
    let backdropPath: String?
    
    enum CodingKeys: String, CodingKey {
        case id, title, overview
        case releaseDate = "release_date"
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
    }
}

extension MoviesDTO {
    func toEntity() -> Movie {
        return Movie(
            id: self.id,
            title: self.title,
            releaseDate: self.releaseDate,
            backdropPath: self.overview,
            overview: self.posterPath ?? "",
            posterPath: self.backdropPath ?? ""
        )
    }
}
