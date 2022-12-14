//
//  Product.swift
//  H3MShop
//
//  Created by Lê Văn Huy on 26/10/2022.
//

import Foundation

class Product: Codable,Identifiable {
    
    let _id : String
    let name: String
    let status: String
    let slug: String
    let urlImage: [String]
    let sold: Int
    let id_cate: String
    let discount: Int
    let size: [Sizes]
    let color: [Colors]
    let description: String
    let price: Int
    let sellDay: String
    let weight: Double
    
    
    init(_id: String,name: String,rate: Double,status: String,slug:String,urlImage: [String], sold: Int,id_cate: String,size:[Sizes],color:[Colors],description: String,price: Int,sellDay: String,weight: Double,discount: Int){
        self._id = _id
        self.name = name
        self.status = status
        self.slug = slug
        self.urlImage = urlImage
        self.sold = sold
        self.id_cate = id_cate
        self.price = price
        self.sellDay = sellDay
        self.weight = weight
        self.color = color
        self.size = size
        self.description = description
        self.discount = discount
    }
}

class MainProduct: Codable,Identifiable {
    var products: [Product]
    var count: Int
}

class WishList: Codable,Identifiable {
    var _id: String
    var id_product: WishListProduct
    var sum: Int
    var amount: Int
    var rate: Float
    
    init(_id: String = "", id_product: WishListProduct = WishListProduct(),sum: Int = 0, amount: Int = 0, rate: Float = 0){
        self._id = _id
        self.id_product = id_product
        self.sum = sum
        self.amount = amount
        self.rate = rate
    }
}

class WishListResponse: Codable,Identifiable {
    var message: String
    var products: [WishList]
}


class WishListProduct: Codable{
    var _id: String
    var name : String
    var status: String
    var slug: String
    var urlImage: [String]
    var sold: Int
    var size: [String]
    var color: [String]
    var description: String
    var discount: Int
    var price: Int
    
    init(_id: String = "", name: String = "", status: String = "", slug: String = "", urlImage: [String] = [], sold: Int = 0, size: [String] = [], color: [String] = [], discount: Int = 0, price: Int = 0,description: String = "") {
        self._id = _id
        self.name = name
        self.status = status
        self.slug = slug
        self.urlImage = urlImage
        self.sold = sold
        self.size = size
        self.color = color
        self.discount = discount
        self.price = price
        self.description = description
    }
}
