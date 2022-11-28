//
//  Rate.swift
//  H3MShop
//
//  Created by Lê Văn Huy on 06/11/2022.
//

import Foundation
class Rate: Codable{
    var _id: String
    var id_product: String
    var rate: Double
    var sum: Int
    var amount: Int
    
    init(_id: String = "" , id_product: String = "" , rate: Double = 0, sum: Int = 0, amount: Int = 0) {
        self._id = _id
        self.id_product = id_product
        self.rate = rate
        self.sum = sum
        self.amount = amount
    }
}
