//
//  WathclistSingleView.swift
//  MovieApp
//
//  Created by Valeh Ismayilov on 13.01.26.
//

import SwiftUI
import SwiftData

struct WathclistSingleView: View {
    let movie: MovieDetailsEntity
    var body: some View {
        HStack(alignment:.top,spacing: 16) {
            imageView
            VStack(alignment: .leading,spacing: 12) {
                title
                genre
                releaseDate
                runtime
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    @ViewBuilder
    var imageView: some View {
        if let posterURL = movie.localPosterURL,
           let imageData = try? Data(contentsOf: posterURL),
            let uiImage = UIImage(data: imageData) {
            Image(uiImage: uiImage)
                .resizable()
                .aspectRatio(2/3, contentMode: .fill)
                .frame(width: 90, height: 140)
                .clipped()
                .cornerRadius(8)
        } else {
            RoundedRectangle(cornerRadius: 8)
                .fill(Color.gray.opacity(0.3))
                .frame(width: 95, height: 140)
                .overlay {
                    Image(systemName: "film")
                        .foregroundColor(.gray)
                }
        }
    }
    
    var title: some View {
        Text(movie.title)
            .appFont(name: .poppinsRegular, size: 16,foregroundColor: .white)
            .multilineTextAlignment(.leading)
    }
    
    @ViewBuilder
    var genre: some View {
        HStack(spacing: 4) {
            Image(.genre)
                .resizable()
                .scaledToFit()
                .foregroundStyle(.white)
                .frame(width: 18,height: 18)
            
            Text(movie.genres?.name ?? "Genre unavailable")
                .appFont(name: .poppinsRegular, size: 12,foregroundColor: .white)
        }
        
    }
    
    @ViewBuilder
    var releaseDate: some View {
        HStack(spacing: 4) {
            Image(.calendar)
                .resizable()
                .scaledToFit()
                .foregroundStyle(.white)
                .frame(width: 18,height: 18)
            
            Text(movie.releaseDate.dateFormatter())
                .appFont(name: .poppinsRegular, size: 12,foregroundColor: .white)
        }
    }
    
    @ViewBuilder
    var runtime: some View {
        HStack(spacing: 4) {
            Image(.clock)
                .resizable()
                .scaledToFit()
                .foregroundStyle(.white)
                .frame(width: 18,height: 18)
            
            
            Text("\(movie.runtime) minutes")
                .appFont(name: .poppinsRegular, size: 12,foregroundColor: .white)
                .lineLimit(1)
                .minimumScaleFactor(0.8)
        }
    }
}
