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
    @Published var savedMovies: [MovieModel] = []
    
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
            let searchResult = try await NetworkManager.shared.searchMovies(search: search)
            moviesList = searchResult
            addMoviesIntoCoreData(movies: searchResult)
            objectWillChange.send()
        } catch {
            throw error
        }
    }
    
    func fetchCoreDataMovies() {
        let request = NSFetchRequest<MovieEntity>(entityName: "MovieEntity")
        
        do {
            let savedEntities = try container.viewContext.fetch(request)
            savedMovies = savedEntities.map { entity in
                return MovieModel(
                    title: entity.title,
                    year: entity.year,
                    imdbID: entity.imdbID,
                    type: entity.type,
                    poster: entity.poster
                )
            }
        } catch let error {
            print("Error fetching from core data: \(error)")
        }
    }
    
    func addMoviesIntoCoreData(movies: [MovieModel]) {
        for movieModel in movies {
            let request = NSFetchRequest<MovieEntity>(entityName: "MovieEntity")
            request.predicate = NSPredicate(format: "imdbID == %@", movieModel.imdbID ?? "")
            
            do {
                let existingMovies = try container.viewContext.fetch(request)
                if existingMovies.isEmpty {
                    let movieEntity = MovieEntity(context: container.viewContext)
                    movieEntity.imdbID = movieModel.imdbID
                    movieEntity.poster = movieModel.poster
                    movieEntity.title = movieModel.title
                    movieEntity.type = movieModel.type
                    movieEntity.year = movieModel.year
                }
            } catch let error {
                print("Error fetching existing movies from core data: \(error)")
            }
        }
        
        do {
            try container.viewContext.save()
            fetchCoreDataMovies()
            saveData()
        } catch let error {
            print("Error saving into core data: \(error)")
        }
    }
    
    func saveData() {
        do {
            try container.viewContext.save()
            fetchCoreDataMovies()
        } catch let error {
            print("Error saving into core data: \(error)")
        }
    }
    
    func logOut() throws {
        try AuthManager.shared.signOut()
    }
}
