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
        ZStack {
            RoundedRectangle(cornerRadius: 16)
                .frame(height: 42)
                .foregroundStyle(.glaucophobia)
            HStack(spacing:0) {
                ZStack(alignment: .leading) {
                    if text.isEmpty {
                        Text(placeholder)
                            .appFont(name: .poppinsRegular, size: 14,foregroundColor: .midnightGrey)
                    }
                    TextField("", text: $text)
                        .autocorrectionDisabled()
                        .appFont(name: .poppinsRegular, size: 14,foregroundColor: .white)
                }
                
                Spacer()
                
                if text.isEmpty {
                    Image(.search)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 16,height: 16)
                } else {
                    Button {
                        text = ""
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(.App.midnightGrey)
                    }

                }
            }
            .padding(.vertical,10)
            .padding(.leading,24)
            .padding(.trailing,16)
        }
    }
}

#Preview {
    @State var text: String = ""
    SearchField(text: $text)
}
