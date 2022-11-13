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
