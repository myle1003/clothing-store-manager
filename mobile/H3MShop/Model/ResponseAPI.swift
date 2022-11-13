//
//  CheckLogin.swift
//  H3MShop
//
//  Created by Van Huy on 24/10/2022.
//

import Foundation

class LoginResponse: Codable,Equatable {
    static func == (lhs: LoginResponse, rhs: LoginResponse) -> Bool {
        lhs === rhs
    }
    var message: String = ""
    var status:Bool = false
    var token: String?
}


class GetUserResponse: Codable {
    var message: String
    var user: User?
    var status: Bool
}

class ForgotResponse: Codable,Equatable {
    static func == (lhs: ForgotResponse, rhs: ForgotResponse) -> Bool {
        lhs === rhs
    }
    
    var message: String
    var status: Bool
    
    init(message: String = "",status: Bool = true){
        self.message = message
        self.status = status
    }
}
