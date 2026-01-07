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
            if let image = loader.image {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: contentMode)
                    .transition(.opacity.animation(.easeInOut))
            } else {
                ZStack {
                    Color.App.glaucophobia
                    ProgressView().tint(.skyCaptain)
                }
            }
        }
        .onAppear {
            loader.load(
                urlString: "https://image.tmdb.org/t/p/w500\(path)"
            )
        }
    }
}
