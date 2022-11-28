//
//  User.swift
//  H3MShop
//
//  Created by Van Huy on 24/10/2022.
//

import Foundation

class RegisterRequest: Codable {
    var name: String
    var email: String
    var password: String
    var password2: String
    
    init(name: String, email: String, password: String, password2: String){
        self.name = name
        self.email = email
        self.password = password
        self.password2 = password2
    }
    
}

class LoginRequest: Codable {
    var email: String
    var password: String
    
    
    init(email: String, password: String){
        self.email = email
        self.password = password
    }
    
}

class ResetPasswordRequest: Codable {
    var current_password: String
    var password: String
    var password2: String
    
    init(current_password: String,password: String,password2: String){
        self.current_password = current_password
        self.password = password
        self.password2 = password2
    }
}
