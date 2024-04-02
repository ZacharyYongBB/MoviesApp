//
//  MovieDetailsViewModel.swift
//  MoviesApp
//
//  Created by Zachary on 2/4/24.
//

import Foundation

@MainActor
final class MovieDetailsViewModel: ObservableObject {
    
    func searchMovieId(movieID: String) async throws -> MovieDetailModel {
        do {
            let movie = try await NetworkManager.shared.searchMovieId(searchId: movieID)
            return movie
        } catch {
            throw ErrorMessage.invalidData
        }
    }
    
}
