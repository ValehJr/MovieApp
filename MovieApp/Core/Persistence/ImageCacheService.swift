//
//  ImageCacheService.swift
//  MovieApp
//
//  Created by Valeh Ismayilov on 12.01.26.
//

import Foundation
import UIKit

actor ImageCacheService {
    static let shared = ImageCacheService()
    private let cacheDir: URL

    private init() {
        cacheDir = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask)[0]
            .appendingPathComponent("MovieImages", isDirectory: true)
        try? FileManager.default.createDirectory(at: cacheDir, withIntermediateDirectories: true)
    }

    func downloadAndCacheImage(from urlString: String, movieID: Int, type: String) async throws -> URL {
        guard let url = URL(string: urlString) else { throw URLError(.badURL) }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        let fileURL = cacheDir.appendingPathComponent("\(movieID)_\(type).jpg")
        
        try data.write(to: fileURL, options: .atomic)
        return fileURL
    }
}
