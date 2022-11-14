//
//  Category.swift
//  H3MShop
//
//  Created by Van Huy on 22/10/2022.
//

import Foundation

class Category: Identifiable,Codable {
    var _id: String
    var name: String
    var slug: String
    
    init(_id: String,name: String,slug: String){
        self._id = _id
        self.name = name
        self.slug = slug
    }
}
