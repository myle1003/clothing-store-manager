//
//  Cart.swift
//  H3MShop
//
//  Created by Lê Văn Huy on 05/11/2022.
//

import Foundation

class Cart: Codable{
    let _id:String
    let product: [ProductResponse]
    let id_account: String
    
    init(_id: String = "", product: [ProductResponse] = [],id_account: String = "") {
        self._id = _id
        self.product = product
        self.id_account = id_account
    }
}

class ProductResponse: Codable,Identifiable{
    let _id: String
    let id_product: ProductRow
    let size: Sizes
    let color: Colors
    let number: Int
    
    init(_id: String = "" , id_product: ProductRow = ProductRow(), size: Sizes = Sizes() , color: Colors = Colors() , number: Int = 0, id_account: String = "") {
        self._id = _id
        self.id_product = id_product
        self.size = size
        self.color = color
        self.number = number
    }
}


class CartRequest: Codable {
    let id_product: String
    let size: String
    let color: String
    let number: Int
    
    init(id_product: String , size: String, color: String , number: Int) {
        self.id_product = id_product
        self.size = size
        self.color = color
        self.number = number
    }
}

class CartResponse: Codable,Equatable {
    static func == (lhs: CartResponse, rhs: CartResponse) -> Bool {
        lhs === rhs
    }
    
    let cart: Cart
    let price: Int
    
    init(cart: Cart = Cart() , price: Int = 0) {
        self.cart = cart
        self.price = price
    }
}

class ProductRow: Codable{
    let _id: String
    let name: String
    let urlImage: [String]
    let price: Int
    let discount: Int
    
    init(_id: String = "" , name: String = "" , urlImage: [String] = [] , price: Int = 0,discount:Int = 0) {
        self._id = _id
        self.name = name
        self.urlImage = urlImage
        self.price = price
        self.discount = discount
    }
}

class CartUpdateRequest: Codable {
    let id: String
    let number: Int
    
    init(id: String, number: Int){
        self.id = id
        self.number = number
    }
}
