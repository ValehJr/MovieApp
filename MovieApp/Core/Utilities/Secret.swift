//
//  Secrets.swift
//  MovieApp
//
//  Created by Valeh Ismayilov on 05.01.26.
//

import Foundation

enum Secret {
    static var tmdbKey: String {
        guard
            let path = Bundle.main.path(forResource: "Secret", ofType: "plist"),
            let dict = NSDictionary(contentsOfFile: path),
            let key = dict["API_KEY"] as? String,
            !key.isEmpty
        else {
            fatalError("API_KEY not found in Secret.plist")
        }

        return key
    }
}
