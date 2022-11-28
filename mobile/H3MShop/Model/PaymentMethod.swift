//
//  PaymentMethod.swift
//  H3MShop
//
//  Created by Lê Văn Huy on 12/11/2022.
//

import Foundation
class PaymentMethod: Codable,Identifiable {

    var _id: String
    var name: String
    var card: [Card]?
    
    init(_id: String = "" , name: String = "" , card: [Card] = []) {
        self._id = _id
        self.name = name
        self.card = card
    }
}

class PaymentMethodResponse: Codable {
    var message: String
    var payment_method: [PaymentMethod]
    var status: Bool
}
