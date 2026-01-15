//
//  MovieHeroHeaderView.swift
//  MovieApp
//
//  Created by Valeh Ismayilov on 14.01.26.
//

import SwiftUI

struct MovieHeroHeaderView: View {
    let backdropPath: String?
    let posterPath: String?
    let title: String?
    
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            backdrop
            heroContent
                .padding(.leading,28)
                .padding(.trailing)
        }
    }
    
    @ViewBuilder
    var backdrop: some View {
        if let path = backdropPath {
            RemoteImageView(
                path: path,
                contentMode: .fill
            )
            .frame(height: 210)
            .clipped()
        }
        
    }
    
    @ViewBuilder
    var poster: some View {
        if let path = posterPath {
            RemoteImageView(
                path: path,
                contentMode: .fill
            )
            .frame(width: 95,height: 120)
            .aspectRatio(2/3, contentMode: .fit)
            .clipShape(RoundedRectangle(cornerRadius: 16))
        }
        
    }
    
    @ViewBuilder
    var titleView: some View {
        if let title = title {
            Text(title)
                .appFont(name: .poppinsSemiBold, size: 24,foregroundColor: .white)
                .multilineTextAlignment(.leading)
                .frame(maxWidth: .infinity,alignment: .leading)
        }
    }
    
    var heroContent: some View {
        HStack(spacing: 12) {
            poster
            titleView
        }
        .padding(.bottom, -60)
    }
}

#Preview {
    MovieHeroHeaderView(backdropPath: "", posterPath: "", title: "Valeh")
}
