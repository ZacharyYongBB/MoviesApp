//
//  UserManager.swift
//  MoviesApp
//
//  Created by Zachary on 2/4/24.
//

import Foundation

struct DBUser {
    let userId : String
    let email : String?
    let picture : String?
    let dateCreated : Date?
}

final class UserManager {
    
    static let shared = UserManager()
    private init() { }
    
    func createNewUser(auth: AuthDataResModel) async throws {
        var userData: [String:Any] = [
            "user_id" : auth.uid,
            "date_created" : Date.now,
        ]
        if let email = auth.email {
            userData["email"] = email
        }
//        try await Firestore.firestore().collection("users").document(auth.uid).setData(userData, merge: false)
    }
    
//    func getUser(userId: String) async throws -> DBUser {
//        let snapshot = try await Firestore.firestore().collection("users").document(userId).getDocument()
//        
//        guard let data = snapshot.data(), let userId = data["user_id"] as? String else {
//            throw URLError(.badServerResponse)
//        }
//        
//        let email = data["email"] as? String
//        let picture = data["picture"] as? String
//        let timestamp = data["date_created"] as? Timestamp
//        let dateCreated = timestamp?.dateValue()
//        
//        return DBUser(userId: userId, email: email, picture: picture, dateCreated: dateCreated)
//        
//    }
    
}
