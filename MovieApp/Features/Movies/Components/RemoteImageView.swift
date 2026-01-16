//
//  RemoteImageView.swift
//  MovieApp
//
//  Created by Valeh Ismayilov on 07.01.26.
//

import SwiftUI

struct RemoteImageView: View {
    @StateObject private var loader = ImageLoader()
    let path: String
    let contentMode: ContentMode

    var body: some View {
        ZStack {
            if path.isEmpty {
                placeholderView
            } else if let image = loader.image {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: contentMode)
                    .transition(.opacity.animation(.easeInOut))
            } else {
                shimmerView
            }
        }
        .onAppear {
            if !path.isEmpty {
                loader.load(urlString: "https://image.tmdb.org/t/p/w500\(path)")
            }
        }
    }

    private var placeholderView: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.white.opacity(0.1))
            
            Image(systemName: "film")
                .font(.largeTitle)
                .foregroundColor(.white.opacity(0.5))
        }
    }

    private var shimmerView: some View {
        RoundedRectangle(cornerRadius: 16)
            .fill(Color.white.opacity(0.1))
            .shimmer()
    }
}
