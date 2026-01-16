//
//  MovieSearchList.swift
//  MovieApp
//
//  Created by Valeh Ismayilov on 16.01.26.
//

struct MovieSearchList: Codable {
    let results: [MovieSearchDTO]?
    let page: Int?
    let total_results: Int?
    let total_pages: Int?
}
