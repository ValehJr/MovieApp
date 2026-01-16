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
        // 1. Prepare an empty array for the genre entities
        var genreEntities: [MovieGenreEntity] = []

        // 2. Loop through the genres saved in the snapshot
        if let snapshotGenres = snapshot.genres {
            for genreSnap in snapshotGenres {
                // CHECK: Does this genre already exist in the DB?
                // (Assumes you added the fetchGenre helper to PersistenceService as discussed)
                if let existingGenre = persistence.fetchGenre(id: genreSnap.id) {
                    // Yes: Reuse it
                    genreEntities.append(existingGenre)
                } else {
                    // No: Create a new one
                    let newGenre = MovieGenreEntity(
                        id: genreSnap.id,
                        name: genreSnap.name ?? "N/A"
                    )
                    // Insert it into context so it gets saved
                    persistence.context.insert(newGenre)
                    genreEntities.append(newGenre)
                }
            }
        }

        // 3. Create the Movie Entity using the ARRAY of genres
        let movieEntity = MovieDetailsEntity(
            id: snapshot.id,
            overview: snapshot.overview ?? "N/A",
            title: snapshot.title ?? "N/A",
            runtime: snapshot.runtime ?? 0,
            releaseDate: snapshot.releaseDate ?? "N/A",
            backdropPath: snapshot.backdropPath ?? "N/A",
            posterPath: snapshot.posterPath ?? "N/A",
            genres: genreEntities // Pass the list here
        )
        
        // 4. Save the movie
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
    
    let genres: [MovieGenreSnapshot]?
    
    init(from entity: MovieDetailsEntity) {
        self.id = entity.id
        self.title = entity.title
        self.overview = entity.overview
        self.runtime = entity.runtime
        self.releaseDate = entity.releaseDate
        self.backdropPath = entity.backdropPath
        self.posterPath = entity.posterPath
        
        if let entityGenres = entity.genres {
            self.genres = entityGenres.map {
                MovieGenreSnapshot(id: $0.id, name: $0.name)
            }
        } else {
            self.genres = []
        }
    }
}

struct MovieGenreSnapshot {
    let id: Int
    let name: String?
}
