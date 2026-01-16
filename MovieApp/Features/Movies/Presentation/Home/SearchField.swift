//
//  SearchField.swift
//  MovieApp
//
//  Created by Valeh Ismayilov on 04.01.26.
//

import SwiftUI

struct SearchField: View {
    @Binding var text: String
    var placeholder: String = "Search"
    
    var body: some View {
        HStack(spacing: 0) {
            TextField("", text: $text, prompt:
                        Text(placeholder)
                .font(.custom("Poppins-Regular", size: 14))
                .foregroundColor(.midnightGrey)
            )
            .autocorrectionDisabled(true)
            .appFont(name: .poppinsRegular, size: 14, foregroundColor: .white)
            .keyboardType(.webSearch)
            .textInputAutocapitalization(.never)
            .submitLabel(.search)
            
            Spacer()
            
            if !text.isEmpty {
                Button {
                    text = ""
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.midnightGrey)
                }
            } else {
                Image(.search)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 16, height: 16)
            }
        }
        .padding(.vertical, 10)
        .padding(.leading, 24)
        .padding(.trailing, 16)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.glaucophobia)
                .frame(height: 42)
        )
    }
}

#Preview {
    @State var text: String = ""
    SearchField(text: $text)
}
