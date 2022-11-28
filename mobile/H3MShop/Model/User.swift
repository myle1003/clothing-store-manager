//
//  User.swift
//  H3MShop
//
//  Created by Lê Văn Huy on 31/10/2022.
//

import Foundation

class User: Codable,Equatable {
    
    static func == (lhs: User, rhs: User) -> Bool {
        return lhs === rhs
    }
    
    var _id: String
    var fullname: String
    var id_account: String
    var phone: String
    var gender: Bool
    var urlImage: String
    
    init(_id: String = "" , fullname: String = "", id_account: String = "" ,phone: String = "" ,gender: Bool = true,urlImage: String = "" ){
        self._id = _id
        self.fullname = fullname
        self.id_account = id_account
        self.phone = phone
        self.gender = gender
        self.urlImage = urlImage
    }
}

class UserRequest: Codable {
    
    var fullname: String
    var phone: String
    var gender: Bool
    
    init(fullname: String, phone: String,gender: Bool){
        self.fullname = fullname
        self.phone = phone
        self.gender = gender
    }
}
