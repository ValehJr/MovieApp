//
//  MoviewReviewDTO.swift
//  MovieApp
//
//  Created by Valeh Ismayilov on 07.01.26.
//

import Foundation

struct MovieReviewsDTO: Identifiable,Codable {
    let id: String
    let author: String
    let content: String
}

extension MovieReviewsDTO {
    func toDomain() -> MovieReviews {
        let review = MovieReviews(
            id: self.id,
            author: self.author,
            content: self.content
        )
        return review
    }
}
