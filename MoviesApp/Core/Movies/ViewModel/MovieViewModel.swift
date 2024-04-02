//
//  MovieViewModel.swift
//  MoviesApp
//
//  Created by Zachary on 2/4/24.
//

import Foundation

@MainActor
final class MovieViewModel: ObservableObject {
    
    func searchMovie(search: String) async -> [MovieModel] {
        do {
            let movies = try await NetworkManager.shared.searchMovies(search: search)
            return movies
        } catch {
            return []
        }
    }
    
    func logOut() throws {
        try AuthManager.shared.signOut()
    }
    
}
