//
//  MovieView.swift
//  MovieApp
//
//  Created by Valeh Ismayilov on 04.01.26.
//

import SwiftUI

struct MovieView: View {
    let moviePosterPath: String?

    var body: some View {
        RemoteImageView(
            path: moviePosterPath ?? "",
            contentMode: .fill
        )
        .aspectRatio(2/3, contentMode: .fit)
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }
}


#Preview {
    MovieView(moviePosterPath: "")
}
