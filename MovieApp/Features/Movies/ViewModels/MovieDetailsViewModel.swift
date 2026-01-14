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
            let movies = try await repository.fetchMovieReviews(id: movieID,page: reviewPage)
            
            if page == 1 {
                movieReviews = movies
            } else {
                movieReviews.append(contentsOf: movies)
            }
            
            canLoadMore = movies.count > 0
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
            print("Faild to fetch credits of the movie: \(error)")
        }
    }
}

extension MovieDetailsViewModel {
    func toggleFavorite() async {
        guard let movieDetails else { return }
        
        do {
            if isSaved {
                try persistence.deleteMovie(id: movieID)
                isSaved = false
                return
            }

            let genreDTO = movieDetails.genres.first {
                $0.id > 0 && !$0.name.isEmpty
            }

            var genreEntity: MovieGenreEntity?

            if let genreDTO {
                genreEntity = MovieGenreEntity(
                    id: genreDTO.id,
                    name: genreDTO.name
                )
                persistence.context.insert(genreEntity!)
            }

            let movieEntity = MovieDetailsEntity(
                id: movieDetails.id,
                overview: movieDetails.overview,
                title: movieDetails.title,
                runtime: movieDetails.runtime,
                releaseDate: movieDetails.releaseDate,
                backdropPath: movieDetails.backdropPath,
                posterPath: movieDetails.posterPath,
                genres: genreEntity
            )
            
            try persistence.saveMovie(movieEntity)

            async let posterURL = ImageCacheService.shared.downloadAndCacheImage(
                from: "https://image.tmdb.org/t/p/w500\(movieEntity.posterPath)",
                movieID: movieEntity.id,
                type: "poster"
            )

            async let backdropURL = ImageCacheService.shared.downloadAndCacheImage(
                from: "https://image.tmdb.org/t/p/original\(movieEntity.backdropPath)",
                movieID: movieEntity.id,
                type: "backdrop"
            )

            movieEntity.posterURL = try await posterURL
            movieEntity.backdropURL = try await backdropURL

            try persistence.context.save()

            isSaved = true

        } catch {
            print("Failed to toggle favorite:", error)
        }
    }
    
    func refreshFavoriteStatus() {
        isSaved = persistence.isMovieSaved(id: movieID)
    }
}
