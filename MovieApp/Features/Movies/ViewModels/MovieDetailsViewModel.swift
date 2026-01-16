//
//  MovieDetailsViewModel.swift
//  MovieApp
//
//  Created by Valeh Ismayilov on 07.01.26.
//

import Combine
import SwiftUI
import SwiftData

enum DetailsInformation: String, CaseIterable, Identifiable {
    case aboutMovie
    case reviews
    case cast
    
    var id: String { self.rawValue }
    var title: String {
        switch self {
        case .aboutMovie: return "About the movie"
        case .reviews: return "Reviews"
        case .cast: return "Cast"
        }
    }
}


@MainActor
class MovieDetailsViewModel: ObservableObject {
    @Published var movieDetails: MovieDetails?
    @Published var movieReviews: [MovieReviews] = []
    @Published var movieCast: [MovieCast] = []
    @Published private(set) var error: String?
    @Published var selectedDetail: DetailsInformation = .aboutMovie
    @Published private(set) var isLoading = false
    @Published var isSaved: Bool = false
    
    let movieDetailTypes: [DetailsInformation] = .init(DetailsInformation.allCases)
    private let movieID: Int
    private let repository: MovieDetailsProtocol
    
    private var reviewPage: Int = 1
    private var canLoadMore = true
    
    private let persistence: PersistenceService
    
    init(
        movieID: Int,
        repository: MovieDetailsProtocol,
        persistence: PersistenceService
    ) {
        self.movieID = movieID
        self.repository = repository
        self.persistence = persistence
    }
    
    func fetchMovieDetails() async {
        error = nil
        
        do {
            movieDetails = try await repository.fetchMovieDetails(id: movieID)
        } catch {
            self.error = error.localizedDescription
            print("Failed to fetch details of the movie: \(error)")
        }
    }
    
    func fetchReviews(nextPage: Bool = false) async {
        guard !isLoading, canLoadMore else { return }
        
        isLoading = true
        defer { isLoading = false }
        
        let page = nextPage ? reviewPage + 1 : 1
        
        do {
            let reviews = try await repository.fetchMovieReviews(id: movieID,page: page)
            
            if page == 1 {
                movieReviews = reviews
            } else {
                movieReviews.append(contentsOf: reviews)
            }
            
            canLoadMore = reviews.count > 0
            reviewPage = page
        } catch {
            self.error = error.localizedDescription
        }
    }
    
    func fetchMovieCredits() async {
        error = nil
        
        do {
            movieCast = try await repository.fetchMovieCredits(id: movieID)
        } catch {
            self.error = error.localizedDescription
            print("Failed to fetch credits of the movie: \(error)")
        }
    }
}

extension MovieDetailsViewModel {
    func toggleFavorite() async {
        guard let movieDetails = self.movieDetails else { return }
        
        do {
            if isSaved {
                try persistence.deleteMovie(id: movieID)
                isSaved = false
            } else {
                var genreEntities: [MovieGenreEntity] = []
                
                if let rawGenres = movieDetails.genres {
                    for dto in rawGenres {
                        if let existingGenre = persistence.fetchGenre(id: dto.id) {
                            genreEntities.append(existingGenre)
                        } else {
                            let newGenre = MovieGenreEntity(
                                id: dto.id,
                                name: dto.name ?? "N/A"
                            )
                            genreEntities.append(newGenre)
                        }
                    }
                }
                
                let movieEntity = MovieDetailsEntity(
                    id: movieDetails.id,
                    overview: movieDetails.overview ?? "N/A",
                    title: movieDetails.title ?? "N/A",
                    runtime: movieDetails.runtime ?? 0,
                    releaseDate: movieDetails.releaseDate ?? "N/A",
                    backdropPath: movieDetails.backdropPath ?? "N/A",
                    posterPath: movieDetails.posterPath ?? "N/A",
                    genres: genreEntities
                )
                
                try persistence.saveMovie(movieEntity)
                self.isSaved = true
                
                let posterPath = movieDetails.posterPath ?? ""
                let backdropPath = movieDetails.backdropPath ?? ""
                let mid = movieDetails.id
                
                Task.detached(priority: .background) {
                    _ = try? await ImageCacheService.shared.downloadAndCacheImage(
                        from: "https://image.tmdb.org/t/p/w500\(posterPath)",
                        movieID: mid,
                        type: "poster"
                    )
                    
                    _ = try? await ImageCacheService.shared.downloadAndCacheImage(
                        from: "https://image.tmdb.org/t/p/original\(backdropPath)",
                        movieID: mid,
                        type: "backdrop"
                    )
                }
            }
        } catch {
            print("Toggle favorite failed: \(error)")
        }
    }
    
    func refreshFavoriteStatus() {
        isSaved = persistence.isMovieSaved(id: movieID)
    }
}
