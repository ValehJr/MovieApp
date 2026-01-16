//
//  MovieReview.swift
//  MovieApp
//
//  Created by Valeh Ismayilov on 07.01.26.
//

import SwiftUI

struct MovieReviewView: View {
    let review: MovieReviews
    @State private var isExpanded: Bool = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            author
            content
            lessMoreButton
                .frame(maxWidth: .infinity,alignment: .trailing)
        }
    }
    
    var author: some View {
        Text(review.author ?? "N/A")
            .appFont(name: .poppinsMedium, size: 14, foregroundColor: .white)
    }
    
    var content: some View {
        Text(review.content ?? "N/A")
            .appFont(name: .poppinsMedium, size: 14, foregroundColor: .brilliance)
            .lineLimit(isExpanded ? nil : 3)
    }
    
    var lessMoreButton: some View {
        Button(action: {
            withAnimation(.easeInOut) {
                isExpanded.toggle()
            }
        }) {
            Text(isExpanded ? "Less" : "More")
                .appFont(name: .poppinsSemiBold, size: 12, foregroundColor: .brilliance)
        }
        .padding(.top, 2)
    }
}

#Preview {
    MovieReviewView(review: .init(id: "1",author: "Valeh", content: "Hello World"))
}
