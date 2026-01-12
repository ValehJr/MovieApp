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
    
    init(id: Int, name: String) {
        self.id = id
        self.name = name
    }
}
