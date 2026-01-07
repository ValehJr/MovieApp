//
//  Movie.swift
//  MovieApp
//
//  Created by Valeh Ismayilov on 05.01.26.
//

import Foundation

struct Movie: Identifiable, Equatable, Hashable {
    let id: Int
    let title: String
    let releaseDate: String
    let backdropPath: String
    let overview: String
    let posterPath: String
}
