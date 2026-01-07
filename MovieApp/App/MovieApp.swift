//
//  MovieAppApp.swift
//  MovieApp
//
//  Created by Valeh Ismayilov on 04.01.26.
//

import SwiftUI

@main
struct MovieAppApp: App {
    private let container = DIContainer()
    
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                HomeView(vm: container.makeHomeViewModel())
            }
        }
    }
}
