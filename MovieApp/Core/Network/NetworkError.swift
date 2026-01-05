//
//  NetworkError.swift
//  MovieApp
//
//  Created by Valeh Ismayilov on 05.01.26.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case invalidResponse
    case decoding(Error)
    case httpStatus(Int)
    case underlying(Error)
}

extension NetworkError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Invalid URL."
        case .invalidResponse:
            return "Invalid server response."
        case .decoding:
            return "Failed to decode response."
        case .httpStatus(let code):
            return "HTTP error with status code \(code)."
        case .underlying:
            return "Unexpected network error."
        }
    }
}
