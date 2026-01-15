//
//  MoviesResponseDTO.swift
//  MovieApp
//
//  Created by Valeh Ismayilov on 05.01.26.
//


import Foundation

struct MovieDTO: Codable {
    let id: Int
    let title: String?
    let overview: String?
    let posterPath: String?
    let backdropPath: String?
    let releaseDate: String?
    
    enum CodingKeys: String, CodingKey {
        case id, title, overview
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
        case releaseDate = "release_date"
    }
}

extension MovieDTO {
    func toDomain() -> Movie {
        let movie =  Movie(
            id: self.id,
            title: self.title ?? "N/A",
            releaseDate: self.releaseDate ?? "N/A",
            backdropPath: self.backdropPath ?? "N/A",
            overview: self.overview ?? "N/A",
            posterPath: self.posterPath ?? "N/A"
        )
        return movie
    }
}
