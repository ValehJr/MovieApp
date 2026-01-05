//
//  ResponseValidator.swift
//  MovieApp
//
//  Created by Valeh Ismayilov on 05.01.26.
//

import Foundation

struct ResponseValidator {
    static func validate(_ response: URLResponse) throws {
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.invalidResponse
        }

        guard (200...299).contains(httpResponse.statusCode) else {
            throw NetworkError.httpStatus(httpResponse.statusCode)
        }
    }
}
