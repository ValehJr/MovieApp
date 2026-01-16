//
//  MovieReviewList.swift
//  MovieApp
//
//  Created by Valeh Ismayilov on 07.01.26.
//

import Foundation

struct MovieReviewList: Codable, Identifiable {
    let id: Int
    let page: Int
    let results: [MovieReviewsDTO]?
}
