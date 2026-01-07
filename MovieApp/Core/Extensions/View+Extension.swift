//
//  Text+Extension.swift
//  MovieApp
//
//  Created by Valeh Ismayilov on 04.01.26.
//

import SwiftUI

extension View {
    func appFont(
        name: AppFontNames,
        size: CGFloat,
        foregroundColor: Color = .primary
    ) -> some View {
        self
            .font(.custom(name.rawValue, size: size))
            .foregroundColor(foregroundColor)
    }
    
    func scrollViewModifier(
        isSelected: Bool,
        action: @escaping () -> Void
    ) -> some View {
        modifier(CustomScrollView(
            isSelected: isSelected,
            action: action)
        )
    }
}
