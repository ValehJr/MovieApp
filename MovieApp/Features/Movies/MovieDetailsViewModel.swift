//
//  MovieDetailsViewModel.swift
//  MovieApp
//
//  Created by Valeh Ismayilov on 07.01.26.
//

import Combine
import SwiftUI

@MainActor
class MovieDetailsViewModel: ObservableObject {
    @Published var movieDetails: MovieDetails?
    @Published var movieReviews: [MovieReviews] = []
    @Published var movieCast: [MovieCast] = []
    @Published private(set) var error: String?
    @Published var selectedDetail: DetailsInformation = .aboutMovie
    @Published private(set) var isLoading = false
    
    let movieDetailTypes: [DetailsInformation] = .init(DetailsInformation.allCases)
    private let movieID: Int
    private let repository: MovieDetailsProtocol
    
    private var reviewPage: Int = 1
    private var canLoadMore = true
    
    init(
        movieID: Int,
        repository: MovieDetailsProtocol
    ) {
        self.movieID = movieID
        self.repository = repository
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

enum DetailsInformation: String, CaseIterable, Identifiable {
    case aboutMovie
    case reviews
    case cast
    
    var title: String {
        switch self {
        case .aboutMovie: return "About the movie"
        case .reviews: return "Reviews"
        case .cast: return "Cast"
        }
    }
    
    var id: String { self.rawValue }
}
