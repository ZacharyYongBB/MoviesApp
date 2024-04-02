//
//  ErrorMessage.swift
//  MoviesApp
//
//  Created by Zachary on 2/4/24.
//

import Foundation

enum ErrorMessage: String, Error {
    case unableToComplete = "Unable to complete your request. Please check your internet connection"
    case invalidResponse = "Invalid response from server. Please try again"
    case invalidData = "The data received from the server was invalid. Please try again"
    case invalidURL = "Unable to complete request. Check your Url"
    case missingApiKey = "You dont have an API key, get it from Zachary"
}
