//
//  MovieEntity.swift
//  MovieApp
//
//  Created by Valeh Ismayilov on 12.01.26.
//

import SwiftData
import Foundation

@Model
final class MovieDetailsEntity {
    @Attribute(.unique) var id: Int
    var overview: String
    var title: String
    var runtime: Int
    var releaseDate: String
    var backdropPath: String
    var posterPath: String
    
    @Relationship(deleteRule: .cascade)
    var genres: MovieGenreEntity?

    var posterURL: String?
    var backdropURL: String?
    
    init(
        id: Int,
        overview: String,
        title: String,
        runtime: Int,
        releaseDate: String,
        backdropPath: String,
        posterPath: String,
        genres: MovieGenreEntity?,
        posterURL: String? = nil,
        backdropURL: String? = nil
    ) {
        self.id = id
        self.overview = overview
        self.title = title
        self.runtime = runtime
        self.releaseDate = releaseDate
        self.backdropPath = backdropPath
        self.posterPath = posterPath
        self.genres = genres
        self.posterURL = posterURL
        self.backdropURL = backdropURL
    }
}
