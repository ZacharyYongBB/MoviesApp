//
//  AuthDataResModel.swift
//  MoviesApp
//
//  Created by Zachary on 2/4/24.
//

import Foundation
import FirebaseAuth

struct AuthDataResModel {
    let uid: String
    let email: String?
    
    init(user: User) {
        self.uid = user.uid
        self.email = user.email
    }
}
