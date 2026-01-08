//
//  MovieDetailsProtocol.swift
//  MovieApp
//
//  Created by Valeh Ismayilov on 07.01.26.
//

protocol MovieDetailsProtocol {
    func fetchMovieDetails(id: Int) async throws -> MovieDetails
    func fetchMovieCredits(id: Int) async throws -> [MovieCast]
    func fetchMovieReviews(id: Int, page: Int) async throws -> [MovieReviews]
}
