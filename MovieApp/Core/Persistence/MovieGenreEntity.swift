//
//  MovieGenreEntity.swift
//  MovieApp
//
//  Created by Valeh Ismayilov on 12.01.26.
//


import SwiftData

@Model
final class MovieGenreEntity {
    @Attribute(.unique) var id: Int
    var name: String
    
    // explicit inverse relationship
    // This tells SwiftData: "I am the other side of the 'genres' list in MovieDetailsEntity"
    @Relationship(inverse: \MovieDetailsEntity.genres)
    var movies: [MovieDetailsEntity]?
    
    init(id: Int, name: String) {
        self.id = id
        self.name = name
        self.movies = []
    }
}
