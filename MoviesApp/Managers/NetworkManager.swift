//
//  NetworkManager.swift
//  MoviesApp
//
//  Created by Zachary on 2/4/24.
//

import SwiftUI

class NetworkManager {
    
    static let shared = NetworkManager()
    private let baseUrl = "https://www.omdbapi.com/?apikey="
    let decoder = JSONDecoder()
    
    private init() {
        
    }
    
    
    func searchMovies(search: String) async throws -> [MovieModel] {
        
        guard let apiKey = getApiKey() else {
            throw ErrorMessage.missingApiKey
        }
        
        let endPoint = baseUrl + apiKey + "&s=\(search)&type=movie"
        
        guard let url = URL(string: endPoint) else {
            throw ErrorMessage.invalidURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw ErrorMessage.invalidResponse
        }
        
        do {
            let searchResponse = try decoder.decode(SearchResponse.self, from: data)
            return searchResponse.search
        } catch {
            throw ErrorMessage.invalidData
        }
        
    }
    
    
    func searchMovieId(searchId: String) async throws -> MovieDetailModel {
        
        guard let apiKey = getApiKey() else {
            throw ErrorMessage.missingApiKey
        }
        
        let endPoint = baseUrl + apiKey + "&i=\(searchId)&plot=full"
        
        guard let url = URL(string: endPoint) else {
            throw ErrorMessage.invalidURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw ErrorMessage.invalidResponse
        }
        
        do {
            let movieDetail = try decoder.decode(MovieDetailModel.self, from: data)
            print("Decoding successful:", movieDetail)
            return movieDetail
        } catch {
            print("Decoding error:", error)
            throw ErrorMessage.invalidData
        }
    }
    
    private func getApiKey() -> String? {
        guard let plistPath = Bundle.main.path(forResource: "APIKeys", ofType: "plist"),
              let plistDict = NSDictionary(contentsOfFile: plistPath),
              let apiKey = plistDict["APIKey"] as? String else {
            print("APIKeys.plist not found or APIKey not set")
            return nil
        }
        
        return apiKey
    }
    
    
}
