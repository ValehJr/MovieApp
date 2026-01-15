//
//  MovieCast.swift
//  MovieApp
//
//  Created by Valeh Ismayilov on 07.01.26.
//

struct MovieCast: Identifiable {
    let id: Int
    let name: String?
    let character: String?
    let profilePath: String?
    
    enum CodingKeys: String, CodingKey {
        case id, name, character
        case profilePath = "profile_path"
    }
}
