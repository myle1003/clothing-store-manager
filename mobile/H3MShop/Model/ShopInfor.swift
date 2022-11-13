//
//  ShopInfor.swift
//  H3MShop
//
//  Created by Lê Văn Huy on 06/11/2022.
//

import Foundation

class Infor: Codable {
    
    let address: Address
    let name_shop: String
    let phone: String
    let ig: String
    let facebook: String
    let policy: String
    let card: [Card]
    
    init(address: Address = Address(), name_shop: String = "",phone: String = "", ig: String = "",facebook: String = "",policy: String = "",card: [Card] = []){
        self.address = address
        self.name_shop = name_shop
        self.phone = phone
        self.ig = ig
        self.facebook = facebook
        self.policy = policy
        self.card = card
    }
}

class Card: Codable,Identifiable {
    
    let _id: String
    let name: String
    let number: String
    let bank: String
    
    init(_id: String = "" , name: String = "" , number: String = "" , bank: String = "") {
        self._id = _id
        self.name = name
        self.number = number
        self.bank = bank
    }
    
}

class InforResponse: Codable {
    let message: String
    let infor: Infor
    let status: Bool
    
    init(message: String = "", infor: Infor = Infor(), status: Bool = true){
        self.message = message
        self.infor = infor
        self.status = status
    }
}
