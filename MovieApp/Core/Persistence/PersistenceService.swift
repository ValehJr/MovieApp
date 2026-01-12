//
//  PersistenceService.swift
//  MovieApp
//
//  Created by Valeh Ismayilov on 12.01.26.
//

import SwiftData
import Foundation

@MainActor
class PersistenceService {
    let container: ModelContainer
    let context: ModelContext
    
    init(container: ModelContainer) {
        self.container = container
        self.context = ModelContext(container)
    }
    
    func isMovieSaved(id: Int) -> Bool {
        let descriptor = FetchDescriptor<MovieDetailsEntity>(predicate: #Predicate { $0.id == id })
        do {
            let count = try context.fetchCount(descriptor)
            return count > 0
        } catch {
            print("Error checking saved movie:", error)
            return false
        }
    }
    
    func saveMovie(_ movieDetails: MovieDetailsEntity) async throws -> MovieDetailsEntity {
        context.insert(movieDetails)
        try context.save()
        return movieDetails
    }
    
    func deleteMovie(id: Int) async throws {
        try context.delete(model: MovieDetailsEntity.self, where: #Predicate { $0.id == id })
        try context.save()
    }
    
    func fetchMovie(id: Int) -> MovieDetailsEntity? {
        let descriptor = FetchDescriptor<MovieDetailsEntity>(predicate: #Predicate { $0.id == id })
        return (try? context.fetch(descriptor).first)
    }
}

@MainActor
extension PersistenceService {
    func deleteAllMovies() throws {
        try context.delete(model: MovieDetailsEntity.self)
        try context.delete(model: MovieGenreEntity.self)
        try context.save()
    }
}
