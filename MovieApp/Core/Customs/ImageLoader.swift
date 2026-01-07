//
//  ImageLoader.swift
//  MovieApp
//
//  Created by Valeh Ismayilov on 07.01.26.
//

import SwiftUI
import Combine

class ImageLoader: ObservableObject {
    @Published var image: UIImage? = nil
    private var urlString: String?

    func load(urlString: String) {
        self.urlString = urlString
        
        if let cached = ImageCache.shared.object(forKey: urlString as NSString) {
            self.image = cached
            return
        }

        guard let url = URL(string: urlString) else { return }

        URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let data = data, let downloadedImage = UIImage(data: data) else { return }
            
            ImageCache.shared.setObject(downloadedImage, forKey: urlString as NSString)
            
            DispatchQueue.main.async {
                self.image = downloadedImage
            }
        }.resume()
    }
}
