//
//  MovieViewModel.swift
//  MoviesApp
//
//  Created by Zachary on 2/4/24.
//

import Foundation
import CoreData

@MainActor
final class MovieViewModel: ObservableObject {
    
    let container: NSPersistentContainer
    @Published var moviesList: [MovieModel] = []
    @Published var savedMovies: [MovieEntity] = []
    
    init() {
        container = NSPersistentContainer(name: "MoviesContainer")
        container.loadPersistentStores { description, error in
            if let error = error {
                print(error)
            }
        }
        fetchCoreDataMovies()
    }
    
    func searchMovie(search: String) async throws {
        do {
            moviesList = try await NetworkManager.shared.searchMovies(search: search)
        } catch {
            throw error
        }
    }
    
    func fetchCoreDataMovies() {
        let request = NSFetchRequest<MovieEntity>(entityName: "MovieEntity")
        
        do {
            savedMovies = try container.viewContext.fetch(request)
        } catch let error {
            print("Error fetching from core data: \(error)")
        }
        
    }
    
    func addMoviesIntoCoreData(movies: [MovieModel]) {
        
    }
    
    func logOut() throws {
        try AuthManager.shared.signOut()
    }
    
}
