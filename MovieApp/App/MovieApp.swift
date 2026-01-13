//
//  MovieAppApp.swift
//  MovieApp
//
//  Created by Valeh Ismayilov on 04.01.26.
//

import SwiftUI

@main
struct MovieApp: App {
    let container = DIContainer()
    @State private var selectedTab: TabItems = .home

    var body: some Scene {
        WindowGroup {
            RootView(
                container: container,
                selectedTab: $selectedTab
            )
        }
    }
}
