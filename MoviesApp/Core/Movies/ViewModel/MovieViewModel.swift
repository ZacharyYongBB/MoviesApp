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
        var movies = [MovieModel]()
        do {
            movies = try await NetworkManager.shared.searchMovies(search: search)
        } catch {
            print("\(error)")
        }
        
        return movies
    }
    
    func logOut() throws {
        try AuthManager.shared.signOut()
    }
    
}
