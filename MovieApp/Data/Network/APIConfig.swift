//
//  APIConfig.swift
//  MovieApp
//
//  Created by Valeh Ismayilov on 04.01.26.
//

import Foundation

struct APIConfig {
    static var apiKey: String {
        guard let path = Bundle.main.path(forResource: "Secret", ofType: "plist"),
              let dict = NSDictionary(contentsOfFile: path),
              let key = dict["API_KEY"] as? String else {
            fatalError("Couldn't find API_KEY in Secret.plist")
        }
        return key
    }
    static let baseURL = "https://api.themoviedb.org/3"
}
