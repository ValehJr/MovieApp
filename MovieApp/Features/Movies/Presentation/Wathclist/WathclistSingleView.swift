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
        if let path = movie.posterURL,
           let uiImage = UIImage(contentsOfFile: path) {
            Image(uiImage: uiImage)
                .resizable()
                .aspectRatio(2/3, contentMode: .fit)
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

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: MovieDetailsEntity.self, configurations: config)
    
    let fantasy = MovieGenreEntity(id: 14, name: "Fantasy")
    let action = MovieGenreEntity(id: 28, name: "Action")
    let adventure = MovieGenreEntity(id: 12, name: "Adventure")
    
    let avatar = MovieDetailsEntity(
        id: 83533,
        overview: "In the wake of the devastating war against the RDA...",
        title: "Avatar: Fire and Ash",
        runtime: 198,
        releaseDate: "2025-12-17",
        backdropPath: "/vm4H1DivjQoNIm0Vs6i3CTzFxQ0.jpg",
        posterPath: "/cf7hE1ifY4UNbS25tGnaTyyDrI2.jpg",
        genres: .init(id: 1, name: "Action"),
        posterURL: "/var/mobile/Containers/Data/Application/FFDFCFE3-974B-4B33-9925-F9751510DE27/Library/Caches/MovieImages/83533_poster.jpg",
        backdropURL: "/var/mobile/Containers/Data/Application/FFDFCFE3-974B-4B33-9925-F9751510DE27/Library/Caches/MovieImages/83533_backdrop.jpg"
    )
    
    WathclistSingleView(movie: avatar)
        .modelContainer(container)
}
