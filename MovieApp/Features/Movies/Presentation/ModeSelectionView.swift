//
//  ModeSelectionView.swift
//  MovieApp
//
//  Created by Valeh Ismayilov on 06.01.26.
//

import SwiftUI

struct ModeSelectionView: View {
    let modes: [MovieMode] = .init(MovieMode.allCases.prefix(4))
    
    @Binding var selectedMode: MovieMode
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(spacing: 16) {
                ForEach(modes) { mode in
                    VStack(spacing: 12) {
                        Text(mode.title)
                            .appFont(name: mode == selectedMode ? .poppinsSemiBold : .poppinsRegular, size: 14,foregroundColor: .white)
                        Rectangle()
                            .frame(height: 4)
                            .foregroundStyle(mode == selectedMode ? .glaucophobia : .clear)
                    }

                    .onTapGesture {
                        withAnimation(.spring()) {
                            selectedMode = mode
                        }
                    }
                }
            }
        }
        .scrollBounceBehavior(.basedOnSize,axes:.horizontal)
        .frame(height: 40)
    }
}

#Preview {
    @State var selectedMode: MovieMode = .nowPlaying
    ModeSelectionView(selectedMode: $selectedMode)
}

enum MovieMode: String, CaseIterable, Identifiable {
    case nowPlaying
    case topRated
    case upcoming
    case popular
    
    var title: String {
        switch self {
        case .nowPlaying:
            return "Now Playing"
        case .topRated:
            return "Top Rated"
        case .upcoming:
            return "Upcoming"
        case .popular:
            return "Popular"
        }
    }
    
    var id: String { self.rawValue }
}
