//
//  MovieViewModel.swift
//  MoviesApp
//
//  Created by Zachary on 2/4/24.
//

import Foundation

@MainActor
final class MovieViewModel: ObservableObject {
    
    func logOut() throws {
        try AuthManager.shared.signOut()
    }
    
}
