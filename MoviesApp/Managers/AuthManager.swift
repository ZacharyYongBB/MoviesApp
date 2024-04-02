//
//  AuthManager.swift
//  MoviesApp
//
//  Created by Zachary on 2/4/24.
//

import Foundation
import FirebaseAuth

final class AuthManager {
    
    static let shared = AuthManager()
    private init() {}
    
    func createUserEmailPw(email: String, password: String) async throws -> AuthDataResModel {
        let  authRes = try await Auth.auth().createUser(withEmail: email, password: password)
        return AuthDataResModel(user: authRes.user)
    }
    
    func getAuthenticatedUser() throws -> AuthDataResModel {
        guard let user = Auth.auth().currentUser else {
            throw URLError(.badServerResponse)
        }
        
        return AuthDataResModel(user: user)
    }
    
    func signInUser(email: String, password: String) async throws -> AuthDataResModel {
        let authRes = try await Auth.auth().signIn(withEmail: email, password: password)
        return AuthDataResModel(user: authRes.user)
    }
    
    func signOut() throws {
        try Auth.auth().signOut()
    }
    
}
