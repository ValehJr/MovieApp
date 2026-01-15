//
//  MovieCastDTO.swift
//  MovieApp
//
//  Created by Valeh Ismayilov on 07.01.26.
//

struct MovieCastDTO: Identifiable, Codable {
    let id: Int
    let name: String?
    let character: String?
    let profilePath: String?
    
    enum CodingKeys: String, CodingKey {
        case id, name, character
        case profilePath = "profile_path"
    }
}

extension MovieCastDTO {
    func toDomain() -> MovieCast {
        let cast = MovieCast(
            id: id,
            name: name ?? "N/A",
            character: character ?? "N/A",
            profilePath: profilePath ?? "N/A"
        )
        return cast
    }
}
