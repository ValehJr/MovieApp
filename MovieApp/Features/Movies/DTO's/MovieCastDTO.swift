//
//  MovieCastDTO.swift
//  MovieApp
//
//  Created by Valeh Ismayilov on 07.01.26.
//

struct MovieCastDTO: Identifiable, Codable {
    let id: Int
    let name: String
    let character: String
}

extension MovieCastDTO {
    func toDomain() -> MovieCast {
        let cast = MovieCast(
            id: id,
            name: name,
            character: character)
        return cast
    }
}
