//
//  Color.swift
//  H3MShop
//
//  Created by Lê Văn Huy on 02/11/2022.
//

import Foundation
class Colors: Codable,Identifiable {
    
    var _id: String
    var name: String
    
    init(_id: String = "" ,name: String = "") {
        self._id = _id
        self.name = name
    }
}
