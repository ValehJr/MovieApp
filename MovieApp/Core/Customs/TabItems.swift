//
//  TabItems.swift
//  MovieApp
//
//  Created by Valeh Ismayilov on 13.01.26.
//

enum TabItems: Int, CaseIterable {
    case home = 0
    case wathclist
    
    var title: String {
        switch self {
        case .home:
            return "Home"
        case .wathclist:
            return "Watchlist"
        }
    }
    
    var icon: String {
        switch self {
        case .home:
            return "home"
        case .wathclist:
            return "wathclist"
        }
    }
}
