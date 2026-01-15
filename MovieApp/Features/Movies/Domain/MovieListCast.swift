//
//  MovieListCreduits.swift
//  MovieApp
//
//  Created by Valeh Ismayilov on 07.01.26.
//

struct MovieListCast: Identifiable, Codable {
    let id: Int
    let cast: [MovieCastDTO]?
}
