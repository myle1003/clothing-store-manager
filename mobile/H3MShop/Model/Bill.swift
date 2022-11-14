//
//  Bill.swift
//  H3MShop
//
//  Created by Lê Văn Huy on 07/11/2022.
//

import Foundation

class BillRequest: Codable,Identifiable{
    var product: [ProductBill]
    var payment_method:String
    var delivery: String
    var weight: Double
    var productPrice: Int
    var shipPrice: Int
    var id_info : String
    
    init(product: [ProductBill] = [], payment_method: String, delivery: String, weight: Double, productPrice: Int, shipPrice: Int, id_info: String) {
        self.product = product
        self.payment_method = payment_method
        self.delivery = delivery
        self.weight = weight
        self.productPrice = productPrice
        self.shipPrice = shipPrice
        self.id_info = id_info
    
    }
}

class ProductBill: Codable,Identifiable{
    var id_product: String
    var size: String
    var color: String
    var number: Int
    var price: Int
    
    init(id_product: String , size: String, color: String, number: Int, price: Int) {
        self.id_product = id_product
        self.size = size
        self.color = color
        self.number = number
        self.price = price
    }
}







class SizeBill: Codable,Identifiable {
    var _id: String
    var name: String
    
    init(_id: String = "" ,name: String = "" ){
        self._id = _id
        self.name = name
    }
}

class ColorBill: Codable,Identifiable {
    var _id: String
    var name: String
    
    init(_id: String = "" ,name: String = "" ){
        self._id = _id
        self.name = name
    }
}


//MARK: id_product
class ProductHistory: Codable {
    var _id: String
    var name: String
    var urlImage:[String]
}


//MARK: product
class ProductBillResponse: Codable,Identifiable{
    var _id: String
    var id_product: ProductHistory
    var size: SizeBill
    var color: ColorBill
    var number: Int
    var price: Int
}

class InfoAddressBill: Codable,Identifiable{
    
    var _id: String
    var address: AddressDetail
    var name: String
    var phone: String
    
    init(_id: String = "",address: AddressDetail = AddressDetail(), name: String = "" , phone: String = "") {
        self._id = _id
        self.address = address
        self.name = name
        self.phone = phone
    }
}





class HistoryBill:Codable,Identifiable {
    var _id: String
    var product: [ProductBillResponse]
    var payment_method: PaymentMethodBill?
    var delivery: DeliveryBill
    var totalPrice: Int
    var productPrice: Int
    var shipPrice: Int
    var createAt: String
    var id_info: InfoAddressBill
    
    init(_id: String = "" , product: [ProductBillResponse] = [], payment_method: PaymentMethodBill = PaymentMethodBill(), totalPrice: Int = 0, productPrice: Int = 0, shipPrice: Int = 0, createAt: String = "", id_info: InfoAddressBill = InfoAddressBill(),delivery: DeliveryBill = DeliveryBill()) {
        self._id = _id
        self.product = product
        self.payment_method = payment_method
        self.totalPrice = totalPrice
        self.productPrice = productPrice
        self.shipPrice = shipPrice
        self.createAt = createAt
        self.id_info = id_info
        self.delivery = delivery
    }
}

class PaymentMethodBill: Codable,Identifiable {

    var _id: String
    var name: String
    
    init(_id: String = "" , name: String = "" ) {
        self._id = _id
        self.name = name
    }
}

class DeliveryBill: Codable{
    var _id: String
    var name: String
    
    init(_id: String = "" , name: String = "" ) {
        self._id = _id
        self.name = name
    }
}


class History: Codable,Identifiable {
    var id_status: Status
    var date: String
    var _id: String
    
}

class Status: Codable {
    var _id: String
    var name: String
    
    init(_id: String = "", name: String = "") {
        self._id = _id
        self.name = name
    }
    
}


class Bill: Codable,Identifiable {
    var _id: String
    var id_bill: HistoryBill
    var history : [History]
    
    init(_id: String = "" , id_bill: HistoryBill, history: [History] = []) {
        self._id = _id
        self.id_bill = id_bill
        self.history = history
    }
}





class BillResponse: Codable {
    var message: String
    var bill: [Bill]
}
