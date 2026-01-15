//
//  MovieListResponse.swift
//  MovieApp
//
//  Created by Valeh Ismayilov on 05.01.26.
//

import Foundation

struct MovieListResponse: Codable {
    let results: [MovieDTO]?
}
