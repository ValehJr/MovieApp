//
//  MovieSearchDTO.swift
//  MovieApp
//
//  Created by Valeh Ismayilov on 16.01.26.
//

struct MovieSearchDTO: Codable, Identifiable {
    let id: Int
    let posterPath: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case posterPath = "poster_path"
    }
}

extension MovieSearchDTO {
    func toDomain() -> MovieSearch {
        let movie = MovieSearch(id: id, posterPath: posterPath)
        return movie
    }
}
