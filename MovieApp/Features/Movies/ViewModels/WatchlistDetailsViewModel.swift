//
//  WatchlistDetailsViewModel.swift
//  MovieApp
//
//  Created by Valeh Ismayilov on 15.01.26.
//

import Foundation
import Combine
import SwiftData

@MainActor
class WatchlistDetailsViewModel: ObservableObject {
    
    @Published var movie: MovieDetailsEntity?
    @Published var isSaved: Bool = true
    @Published private(set) var error: String?
    
    private let id: Int
    private let persistence: PersistenceService
    
    var snapshot: MovieSnapshot?
    
    init(persistence: PersistenceService, id: Int) {
        self.persistence = persistence
        self.id = id
    }
    
    func fetchMovieDetails() {
        movie = persistence.fetchMovie(id: id)
        
        isSaved = movie != nil
        
        if let movie = movie {
            self.snapshot = MovieSnapshot(from: movie)
        }
    }
    
    func toggleFavorite() {
        do {
            if isSaved {
                if let movie = movie {
                    self.snapshot = MovieSnapshot(from: movie)
                }
                
                try persistence.deleteMovie(id: id)
                movie = nil
                isSaved = false
                
            } else {
                guard let snapshot = snapshot else {
                     print("Error: No data available to restore movie.")
                     return
                }
                
                try restoreMovie(from: snapshot)
                isSaved = true
                
                fetchMovieDetails()
            }
        } catch {
            print("Failed to toggle favorite:", error)
            self.error = error.localizedDescription
        }
    }
    
    private func restoreMovie(from snapshot: MovieSnapshot) throws {
        var genreEntity: MovieGenreEntity?
        if let cachedGenre = snapshot.genre {
            genreEntity = MovieGenreEntity(
                id: cachedGenre.id,
                name: cachedGenre.name ?? "N/A"
            )
            if let entity = genreEntity {
                persistence.context.insert(entity)
            }
        }

        let movieEntity = MovieDetailsEntity(
            id: snapshot.id,
            overview: snapshot.overview ?? "N/A",
            title: snapshot.title ?? "N/A",
            runtime: snapshot.runtime ?? 0,
            releaseDate: snapshot.releaseDate ?? "N/A",
            backdropPath: snapshot.backdropPath ?? "N/A",
            posterPath: snapshot.posterPath ?? "N/A",
            genres: genreEntity
        )
        
        try persistence.saveMovie(movieEntity)
    }
}

struct MovieSnapshot {
    let id: Int
    let title: String?
    let overview: String?
    let runtime: Int?
    let releaseDate: String?
    let backdropPath: String?
    let posterPath: String?
    let genre: MovieGenreSnapshot?
    
    init(from entity: MovieDetailsEntity) {
        self.id = entity.id
        self.title = entity.title
        self.overview = entity.overview
        self.runtime = entity.runtime
        self.releaseDate = entity.releaseDate
        self.backdropPath = entity.backdropPath
        self.posterPath = entity.posterPath
        
        if let g = entity.genres {
            self.genre = MovieGenreSnapshot(id: g.id, name: g.name)
        } else {
            self.genre = nil
        }
    }
}

struct MovieGenreSnapshot {
    let id: Int
    let name: String?
}
