//
//  PersistenceService.swift
//  MovieApp
//
//  Created by Valeh Ismayilov on 12.01.26.
//

import SwiftData
import Foundation

@MainActor
final class PersistenceService {
    let container: ModelContainer
    let context: ModelContext

    init(container: ModelContainer) {
        self.container = container
        self.context = ModelContext(container)
    }

    func isMovieSaved(id: Int) -> Bool {
        let descriptor = FetchDescriptor<MovieDetailsEntity>(
            predicate: #Predicate { $0.id == id }
        )
        return (try? context.fetchCount(descriptor)) ?? 0 > 0
    }

    func saveMovie(_ movie: MovieDetailsEntity) throws {
        context.insert(movie)
        try context.save()
    }

    func deleteMovie(id: Int) throws {
        try context.delete(
            model: MovieDetailsEntity.self,
            where: #Predicate { $0.id == id }
        )
        try context.save()
    }

    func fetchMovie(id: Int) -> MovieDetailsEntity? {
        let descriptor = FetchDescriptor<MovieDetailsEntity>(
            predicate: #Predicate { $0.id == id }
        )
        return try? context.fetch(descriptor).first
    }
    
    func fetchAllMovies() async throws -> [MovieDetailsEntity] {
        (try? context.fetch(FetchDescriptor<MovieDetailsEntity>())) ?? []
    }
}

@MainActor
extension PersistenceService {
    func deleteAllMovies() throws {
        try context.delete(model: MovieDetailsEntity.self)
        try context.delete(model: MovieGenreEntity.self)
        
        context.processPendingChanges()
        
        do {
            try context.save()
            print("Successfully deleted all local movie data.")
        } catch {
            context.rollback()
            print("Failed to delete movies: \(error.localizedDescription)")
            throw error
        }
    }
}
