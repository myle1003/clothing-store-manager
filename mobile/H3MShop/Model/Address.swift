//
//  Address.swift
//  H3MShop
//
//  Created by Lê Văn Huy on 01/11/2022.
//

import Foundation

class Address: Codable {
    var id_province: String
    var id_district: String
    var id_commune: String
    var street: String
    
    init(id_province:String = "" ,id_district:String = "", id_commune: String = "" , street: String = ""){
        self.id_province = id_province
        self.id_district = id_district
        self.id_commune = id_commune
        self.street = street
    }
}

class AddressDetail: Codable {
    var id_province: Province
    var id_district: District
    var id_commune: Commune
    var street: String
    init(id_province: Province = Province(), id_district: District = District(), id_commune: Commune = Commune(),street: String = "") {
        self.id_province = id_province
        self.id_district = id_district
        self.id_commune = id_commune
        self.street = street
    }
}


class InfoAddress: Codable,Identifiable,Equatable{
    static func == (lhs: InfoAddress, rhs: InfoAddress) -> Bool {
        lhs === rhs
    }
    
    var _id: String
    var id_account: String?
    var address: AddressDetail
    var name: String
    var phone: String
    var role: Bool
    
    init(_id: String = "",id_account:String = "",address: AddressDetail = AddressDetail(), name: String = "" , phone: String = "",role: Bool = true) {
        self._id = _id
        self.id_account = id_account
        self.address = address
        self.name = name
        self.phone = phone
        self.role = role
    }
}

class inforAddressResponse: Codable{
    var message: String
    var inforAddress: [InfoAddress]
    var status: Bool
}

class AddressRequest: Codable {
    let name: String
    let phone: String
    let address: Address
    let role: Bool
    
    init(name: String, phone: String,address: Address,role: Bool){
        self.name = name
        self.phone = phone
        self.address = address
        self.role = role
    }
}


