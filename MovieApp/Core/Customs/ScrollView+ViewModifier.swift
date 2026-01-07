//
//  ScrollView+ViewModifier.swift
//  MovieApp
//
//  Created by Valeh Ismayilov on 07.01.26.
//

import SwiftUI

struct CustomScrollView: ViewModifier {
    let isSelected: Bool
    let action: () -> Void
    func body(content: Content) -> some View {
        VStack(spacing: 12) {
            content
                .appFont(
                    name: isSelected ? .poppinsSemiBold : .poppinsRegular,
                    size: 14,
                    foregroundColor: .white
                )
            
            Rectangle()
                .frame(height: 4)
                .foregroundStyle(isSelected ? .glaucophobia : .clear)
        }
        .contentShape(Rectangle())
        .onTapGesture {
            withAnimation(.spring()) {
                action()
            }
        }
    }
}
