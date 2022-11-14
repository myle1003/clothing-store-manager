//
//  Number.swift
//  H3MShop
//
//  Created by Lê Văn Huy on 02/11/2022.
//

import Foundation

class Number: Codable {
    let _id: String
    let size: String
    let color: String
    let number: Int
    
    init(_id: String,size:String,color:String,number: Int){
        self._id = _id
        self.size = size
        self.color = color
        self.number = number
    }
}
