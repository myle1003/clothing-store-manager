//
//  Province.swift
//  H3MShop
//
//  Created by Lê Văn Huy on 31/10/2022.
//

import Foundation
class Province: Codable,Identifiable,Equatable {
    
    static func == (lhs: Province, rhs: Province) -> Bool {
        return lhs === rhs
    }
    
    var _id: String
    var name: String
    var region: String?
    
    init(_id: String = "" , name: String = "Choose Province" , region: String = "") {
        self._id = _id
        self.name = name
        self.region = region
    }
}
