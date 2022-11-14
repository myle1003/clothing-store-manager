//
//  Delivery.swift
//  H3MShop
//
//  Created by Lê Văn Huy on 06/11/2022.
//

import Foundation

class Delivery: Codable,Identifiable{
    let _id: String
    var name: String
    var price: Int
    var status: Bool
    var note: String
    
    init(_id: String = "", name: String = "", price: Int = 0, status: Bool = true, note: String = "") {
        self._id = _id
        self.name = name
        self.price = price
        self.status = status
        self.note = note
    }
}

class DeliveryResponse: Codable{
    let message:String
    let delivery: [Delivery]
    let status: Bool
}
