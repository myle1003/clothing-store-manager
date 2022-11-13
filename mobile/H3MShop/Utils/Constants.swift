//
//  Constants.swift
//  H3MShop
//
//  Created by Van Huy on 22/10/2022.
//

import Foundation

import Foundation

enum Constants{
    static let baseURL = "http://103.197.184.7:3002/api/v1/"
}

enum Endpoints{
    static let categories = "cms/categories/all"
    static let register = "web/auth/register"
    static let login = "web/auth/login"
    static let products = "web/products/list/all/1"
    static let provinces = "web/address/province"
    static let districs = "web/address/district"
    static let communes = "web/address/commune"
    static let user = "web/users"
    static let productDetail = "web/products/detail"
    static let cart = "web/cart"
    static let insertCart = "web/cart/insert"
    static let deleteRowCart = "web/cart/delete"
    static let updateRowCart = "web/cart/update"
    static let deliveries = "cms/deliveries"
    static let info = "web/infor"
    static let productsbyCategory = "web/products/"
    static let forgot = "web/auth/forgot"
    static let inforaddress = "web/inforaddress"
    static let paymentMethod = "web/paymentmethod"
    static let insertBill = "web/bill/insert"
    static let getbills = "web/bill/all"
    
}

