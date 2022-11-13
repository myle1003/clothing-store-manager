//
//  Comment.swift
//  H3MShop
//
//  Created by Lê Văn Huy on 06/11/2022.
//

import Foundation
class Comment: Codable,Identifiable{
    let _id: String
    let id_product: String
    let id_account: Account
    let urlImage: [String]
    let content: String
    let star: Int
    
    init(_id: String = "", id_product: String = "" , id_account: Account = Account() , urlImage: [String] = [], content: String = "", star: Int = 0) {
        self._id = _id
        self.id_product = id_product
        self.id_account = id_account
        self.urlImage = urlImage
        self.content = content
        self.star = star
    }
}

class Account: Codable{
    let _id: String
    let name: String
    
    init(_id: String = "", name: String = "") {
        self._id = _id
        self.name = name
    }
}
