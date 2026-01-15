//
//  MovieCast.swift
//  MovieApp
//
//  Created by Valeh Ismayilov on 10.01.26.
//

import SwiftUI

struct MovieCastView: View {
    let cast: MovieCast
    var body: some View {
        HStack(alignment:.bottom,spacing:8) {
            profilePicture
            
            VStack(alignment:.leading) {
                character
                name
            }
            Spacer()
        }
    }
    
    @ViewBuilder
    var profilePicture: some View {
        if let profilePath = cast.profilePath {
            RemoteImageView(path: profilePath, contentMode: .fill)
                .aspectRatio(2/3, contentMode: .fit)
                .clipShape(RoundedRectangle(cornerRadius: 16))
                .frame(width: 80, height: 100)
                
        } else {
            ZStack(alignment:.center) {
                RoundedRectangle(cornerRadius: 12)
                    .foregroundStyle(.glaucophobia)
                    
                Text("Image not available")
                    .appFont(name: .poppinsMedium, size: 12, foregroundColor: .white)
                    .multilineTextAlignment(.center)
            }
            .frame(width: 80, height: 100)
        }
    }
    
    var character: some View {
        Text(cast.character ?? "N/A")
            .appFont(name: .poppinsSemiBold, size: 18,foregroundColor: .white)
    }
    
    var name: some View {
        Text(cast.name ?? "N/A")
            .appFont(name: .poppinsMedium, size: 18,foregroundColor: .white)
    }
}

#Preview {
    MovieCastView(cast: .init(id: 1, name: "Sam Worthington", character: "Jake", profilePath: "/mflBcox36s9ZPbsZPVOuhf6axaJ.jpg"))
}
