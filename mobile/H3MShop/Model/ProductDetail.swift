//
//  ProductDetail.swift
//  H3MShop
//
//  Created by Lê Văn Huy on 02/11/2022.
//

import Foundation

class ProductDetail: Codable,Identifiable {
    let product: Product
    let number: [Number]
    let comment: [Comment]
    let rate: Rate
    
    init(product: Product,number: [Number],comment:[Comment],rate:Rate){
        self.product = product
        self.number = number
        self.comment = comment
        self.rate = rate
    }
}
