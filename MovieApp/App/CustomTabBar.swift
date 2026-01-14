//
//  CustomTabBar.swift
//  MovieApp
//
//  Created by Valeh Ismayilov on 13.01.26.
//

import SwiftUI

struct CustomTabBar: View {
    @Binding var selectedTab: TabItems
    
    var body: some View {
        HStack {
            ForEach(TabItems.allCases, id: \.self) { tab in
                Button {
                    selectedTab = tab
                } label: {
                    VStack(spacing: 6) {
                        Image(tab.icon)
                            .foregroundColor(
                                selectedTab == tab ? .atmosphere : .midnightGrey
                            )
                            .frame(width: 22, height: 22)
                        
                        Text(tab.title)
                            .appFont(name: .poppinsMedium, size: 12, foregroundColor: selectedTab == tab ? .atmosphere : .midnightGrey)
                    }
                    .frame(maxWidth: .infinity)
                }
            }
        }
        .padding(.horizontal, 12)
        .background(.skyCaptain)
    }
}
