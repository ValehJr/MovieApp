//
//  MovieMetaInfoView.swift
//  MovieApp
//
//  Created by Valeh Ismayilov on 14.01.26.
//

import SwiftUI

struct MovieMetaInfoView: View {
    let releaseDate: String?
    let runtime: Int?
    let genre: String?
    
    var runtimeString: String {
        if let runtime = runtime, runtime > 0 {
            return "\(runtime) minutes"
        } else {
            return "N/A"
        }
    }
    
    var body: some View {
        details
    }
    
    var details: some View {
        HStack(spacing: 12) {
            releaseDateView
            rect
            runtimeView
            rect
            genreView
        }
    }
    
    @ViewBuilder
    var releaseDateView: some View {
        HStack(spacing: 4) {
            Image(.calendar)
                .resizable()
                .scaledToFit()
                .frame(width: 18,height: 18)
                .foregroundColor(.lilacFields)
            
            Text(releaseDate?.dateFormatter() ?? "N/A")
                .appFont(name: .poppinsMedium, size: 14,foregroundColor: .lilacFields)
        }
    }
    
    @ViewBuilder
    var runtimeView: some View {
        HStack(spacing: 4) {
            Image(.clock)
                .resizable()
                .scaledToFit()
                .frame(width: 18,height: 18)
                .foregroundColor(.lilacFields)
            
            Text(runtimeString)
                .appFont(name: .poppinsMedium, size: 14,foregroundColor: .lilacFields)
                .lineLimit(1)
                .minimumScaleFactor(0.8)
            
        }
    }
    
    @ViewBuilder
    var genreView: some View {
        Text(genre ?? "N/A")
            .appFont(name: .poppinsMedium, size: 14,foregroundColor: .lilacFields)
            .lineLimit(1)
            .minimumScaleFactor(0.8)
    }
    
    var rect: some View {
        Rectangle()
            .foregroundStyle(.lilacFields)
            .frame(width: 1,height: 16)
    }
}
