//
//  Endpoint+Extension.swift
//  MovieApp
//
//  Created by Valeh Ismayilov on 05.01.26.
//

import Foundation

extension Endpoint {
    static func popularMovies(page: Int) -> Endpoint {
        Endpoint(
            path: "/movie/popular",
            method: .get,
            queryItems: [.init(name: "page", value: "\(page)")]
        )
    }
    
    static func topRatedMovies(page: Int) -> Endpoint {
        Endpoint(
            path: "/movie/top_rated",
            method: .get,
            queryItems: [.init(name: "page", value: "\(page)")]
        )
    }
    
    static func upcomingMovies(page: Int) -> Endpoint {
        Endpoint(
            path: "/movie/upcoming",
            method: .get,
            queryItems: [.init(name: "page", value: "\(page)")]
        )
    }
    
    static func nowPlayingMovies(page: Int) -> Endpoint {
        Endpoint(
            path: "/movie/now_playing",
            method: .get,
            queryItems: [.init(name: "page", value: "\(page)")]
        )
    }
    
    static func movieDetails(id: Int) -> Endpoint {
        Endpoint(
            path: "/movie/\(id)",
            method: .get,
            queryItems: []
        )
    }
    
    static func movieCredits(id: Int) -> Endpoint {
        Endpoint(
            path: "/movie/\(id)/credits",
            method: .get,
            queryItems: []
        )
    }
    
    static func movieReviews(id: Int,page: Int) -> Endpoint {
        Endpoint(
            path: "/movie/\(id)/reviews",
            method: .get,
            queryItems: [.init(name: "page", value: "\(page)")]
        )
    }
    
    static func movieSearch(query: String, page: Int) -> Endpoint {
        Endpoint(
            path: "/search/movie",
            method: .get,
            queryItems: [.init(name: "query", value: query), .init(name: "page", value: "\(page)")]
        )
    }
}
