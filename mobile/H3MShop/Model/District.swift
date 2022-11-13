//
//  District.swift
//  H3MShop
//
//  Created by Lê Văn Huy on 31/10/2022.
//

import Foundation

class District: Codable,Identifiable {
    
    static func == (lhs: District, rhs: District) -> Bool {
        return lhs === rhs
    }
    
    var _id: String
    var id_province: String?
    var name: String
    
    init(_id: String = "" , id_province: String = "" ,name: String = "Choose District"){
        self._id = _id
        self.id_province = id_province
        self.name = name
    }
}
