//
//  CartViewModel.swift
//  H3MShop
//
//  Created by Lê Văn Huy on 07/11/2022.
//

import Foundation
import SwiftUI
class CartViewModel: ObservableObject {
    @AppStorage("token") var token: String = ""
    @Published var carts: CartResponse = CartResponse()
    
    init(){
        self.getCart()
    }
    
    func fetchCart() async throws  -> CartResponse{
        let urlString = Constants.baseURL + Endpoints.cart
        guard let url = URL(string: urlString) else {
            throw httpError.badURL
        }
        let cartResponse: CartResponse = try await HttpClient.shared.fetchDatawithToken(url: url, httpMethod: httpMethod.GET.rawValue, with: token)
        
        return cartResponse
    }
    
    func getCart()  {
        
        Task{
            do{
                    let existedCart: CartResponse = try await self.fetchCart()
                    
                    DispatchQueue.main.async {
                        self.carts = existedCart
                        

                    }
            }
            catch{
                
            }
        }
        
        
    }
    
    func getProductBill() -> [ProductBill]{
        var productsBill = [ProductBill]()
        for product in self.carts.cart.product {
            let productBill = ProductBill(id_product: product.id_product._id, size: product.size._id, color: product.color._id, number: product.number, price: product.id_product.price)
            productsBill.append(productBill)
        }
        return productsBill
    }
    
    func deleteRowCart(id_product: String) async throws {
        
        
        let urlString = Constants.baseURL + Endpoints.deleteRowCart + "/\(id_product)"
        
        guard let url = URL(string: urlString) else {
            throw httpError.badURL
        }
        
        try await HttpClient.shared.deleteData(url: url, httpMethod: httpMethod.DELETE.rawValue, with: token)
        
        self.getCart()
        
        
        
    }
    
    func addtoCart(id_product: String, size: String,color: String, number: Int) async throws {
        
        let urlString = Constants.baseURL + Endpoints.insertCart
        guard let url = URL(string: urlString) else {
            throw httpError.badURL
        }
        
        let cartRequest = CartRequest(id_product: id_product, size: size, color: color, number: number)
        
        try await HttpClient.shared.sendDatawithToken(to: url, object: cartRequest, httpMethod: httpMethod.POST.rawValue, with: token)
        
        self.getCart()
        
    }
    
    func editCart(id_product: String,number: Int) async throws {
        let urlString = Constants.baseURL + Endpoints.updateRowCart
        guard let url = URL(string: urlString) else {
            throw httpError.badURL
        }
        let cartUpdate = CartUpdateRequest(id: id_product, number: number)
        
        try await HttpClient.shared.sendDatawithToken(to: url, object: cartUpdate, httpMethod: httpMethod.PUT.rawValue, with: token)
        
        self.getCart()
    }
    
}
