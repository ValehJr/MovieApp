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
    
    @Relationship(deleteRule: .nullify)
    var genres: [MovieGenreEntity]?
    
    var localPosterURL: URL? {
        let cacheDir = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask)[0]
            .appendingPathComponent("MovieImages")
        let fileURL = cacheDir.appendingPathComponent("\(id)_poster.jpg")
        return FileManager.default.fileExists(atPath: fileURL.path) ? fileURL : nil
    }
    
    var localBackdropURL: URL? {
        let cacheDir = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask)[0]
            .appendingPathComponent("MovieImages")
        let fileURL = cacheDir.appendingPathComponent("\(id)_backdrop.jpg")
        return FileManager.default.fileExists(atPath: fileURL.path) ? fileURL : nil
    }
    
    init(
        id: Int,
        overview: String,
        title: String,
        runtime: Int,
        releaseDate: String,
        backdropPath: String,
        posterPath: String,
        genres: [MovieGenreEntity]? = []
    ) {
        self.id = id
        self.overview = overview
        self.title = title
        self.runtime = runtime
        self.releaseDate = releaseDate
        self.backdropPath = backdropPath
        self.posterPath = posterPath
        self.genres = genres
    }
}
