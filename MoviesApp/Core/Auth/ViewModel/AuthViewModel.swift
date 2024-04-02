//
//  AuthViewModel.swift
//  MoviesApp
//
//  Created by Zachary on 2/4/24.
//

import Foundation
import SwiftUI

@MainActor
final class AuthViewModel: ObservableObject {
    
    @Published var email = ""
    @Published var password = ""
    
    @discardableResult
    func createUser() async throws -> Bool {
        guard !email.isEmpty, !password.isEmpty else {
            print("please enter email / password")
            return false
        }
        
        do {
            let returnedUserData = try await AuthManager.shared.createUserEmailPw(email: email, password: password)
            try await UserManager.shared.createNewUser(auth: returnedUserData)
            return true
        } catch {
            print("error : \(error)")
            return false
        }
        
    }
    
    func signIn() async throws -> Bool {
        
        guard !email.isEmpty, !password.isEmpty else {
            print("please enter email / password")
            return false
        }
        do {
            let returnedUserData = try await AuthManager.shared.signInUser(email: email, password: password)
            print(returnedUserData)
            return true
        } catch {
            print("error : \(error)")
            return false
        }
        
    }
    
    func wrongSignInCredentialsAlert() -> Alert {
        Alert(title: Text("😑 Wrong Credentials ❌"), message: Text("Please ensure you have keyed in the correct Email and Password"))
    }
    
    func accountCreatedAlert(success: Bool) -> Alert {
        if success {
            Alert(title: Text("Account Successfully Created 🔥"), message: Text("Your account has been created. Please proceed to Log In"))
        } else {
            Alert(title: Text("Account Creation Failed 😅"), message: Text("Please ensure right email format with at least 6 characters as password"))
        }
    }
    
    
}
