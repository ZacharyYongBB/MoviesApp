//
//  MovieModel.swift
//  MoviesApp
//
//  Created by Zachary on 2/4/24.
//

import Foundation

struct MovieModel: Codable {
    let title, year, imdbID, type: String?
    let poster: String?
    
    enum CodingKeys: String, CodingKey {
        case title = "Title"
        case year = "Year"
        case imdbID
        case type = "Type"
        case poster = "Poster"
    }
}

struct SearchResponse: Codable {
    let search: [MovieModel]
    let totalResults: String
    let response: String
    
    enum CodingKeys: String, CodingKey {
        case search = "Search"
        case totalResults
        case response = "Response"
    }
}
