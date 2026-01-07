//
//  MovieReview.swift
//  MovieApp
//
//  Created by Valeh Ismayilov on 07.01.26.
//

import SwiftUI

struct MovieReview: View {
    let review: MovieReviews
    var body: some View {
        VStack(alignment:.leading,spacing:4) {
            author
            content
        }
    }
    
    var author: some View {
        Text(review.author)
            .appFont(name: .poppinsMedium, size: 14,foregroundColor: .white)
    }
    
    var content: some View {
        Text(review.content)
            .appFont(name: .poppinsMedium, size: 14,foregroundColor: .white)
    }
}

#Preview {
    MovieReview(review: .init(id: "1",author: "Valeh", content: "Hello World"))
}
