//
//  MovieDetailsDTO.swift
//  MovieApp
//
//  Created by Valeh Ismayilov on 07.01.26.
//

struct MovieDetailsDTO: Codable {
    let id: Int
    let overview: String?
    let title: String?
    let runtime: Int?
    let releaseDate: String?
    let backdropPath: String?
    let posterPath: String?
    let genres: [MovieGenreDTO]?
    
    enum CodingKeys: String, CodingKey {
        case id, overview, title, runtime, genres
        case releaseDate = "release_date"
        case backdropPath = "backdrop_path"
        case posterPath = "poster_path"
    }
}


extension MovieDetailsDTO {
    func toDomain() -> MovieDetails {
        return MovieDetails(
            id: id,
            overview: overview ?? "No description available.",
            title: title ?? "Unknown Title",
            runtime: runtime ?? 0,
            releaseDate: releaseDate ?? "",
            backdropPath: backdropPath ?? "",
            posterPath: posterPath ?? "",
            genres: genres?.map { $0.toDomain() } ?? []
        )
    }
}

struct MovieGenreDTO: Codable {
    let id: Int
    let name: String?
}

extension MovieGenreDTO {
    func toDomain() -> MovieGenre {
        return MovieGenre(id: id, name: name)
    }
}
