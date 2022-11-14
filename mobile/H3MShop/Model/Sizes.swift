//
//  Size.swift
//  H3MShop
//
//  Created by Lê Văn Huy on 02/11/2022.
//

import Foundation
class Sizes: Codable,Identifiable {
    var _id: String
    var name: String
    var description: String
    
    init(_id: String = "" ,name: String = "" , description: String = ""){
        self._id = _id
        self.name = name
        self.description = description
    }
}
