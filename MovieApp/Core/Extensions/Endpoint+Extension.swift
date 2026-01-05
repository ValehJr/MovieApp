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
}
