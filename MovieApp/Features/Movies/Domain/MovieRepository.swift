//
//  MovieRepository.swift
//  MovieApp
//
//  Created by Valeh Ismayilov on 05.01.26.
//

import SwiftUI

protocol MovieRepository {
    func fetchPopularMovies(page: Int) async throws -> [Movie]
    func fetchNowPlayingMovies(page: Int) async throws -> [Movie]
    func fetchTopRatedMovies(page: Int) async throws -> [Movie]
    //func searchMovies(query: String, page: Int) async throws -> [Movie]
    func fetchUpcomingMovies(page: Int) async throws -> [Movie]
}
