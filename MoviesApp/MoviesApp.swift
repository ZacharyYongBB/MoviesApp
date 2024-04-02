//
//  MoviesAppApp.swift
//  MoviesApp
//
//  Created by Zachary on 2/4/24.
//

import SwiftUI
import Firebase

@main
struct MoviesApp: App {
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            RootView()
        }
    }
}
