//
//  Commue.swift
//  H3MShop
//
//  Created by Lê Văn Huy on 31/10/2022.
//

import Foundation

class Commune: Codable,Identifiable,Equatable {
    
    static func == (lhs: Commune, rhs: Commune) -> Bool {
        return lhs === rhs
    }
    
    var _id: String
    var name: String
    var id_district: String?
    
    init(_id: String = "" , name : String = "Choose Commune" , id_district: String = ""){
        self._id = _id
        self.name = name
        self.id_district = id_district
    }
}
