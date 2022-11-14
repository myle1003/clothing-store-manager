//
//  CheckOutViewModel.swift
//  H3MShop
//
//  Created by Lê Văn Huy on 10/11/2022.
//

import Foundation
import SwiftUI
class CheckOutViewModel: ObservableObject {
    
    @AppStorage("token") var token: String = ""
    var delivery: [Delivery] = []
    var info: Infor = Infor()
    var paymentMethod: [PaymentMethod] = []
    
    @Published var defaultDelivery: Delivery = Delivery()
    @Published var defaultPaymentMethod: PaymentMethod = PaymentMethod()
    
    init(){
        
        Task{
            do{
                try await self.fetchPaymentMethod()
                try await self.getInfor()
                try await self.fetchDelivery()
            }
        }
    }
    
    
    func fetchDelivery() async throws {
        let urlString = Constants.baseURL + Endpoints.deliveries
        
        guard let url = URL(string: urlString) else {
            throw httpError.badURL
        }
        
        let deliveriesResponse: DeliveryResponse = try await HttpClient.shared.fetchDatawithToken(url: url, httpMethod: httpMethod.GET.rawValue, with: token)
        
        self.delivery = deliveriesResponse.delivery
        
        DispatchQueue.main.async {
            self.defaultDelivery = deliveriesResponse.delivery.first!
        }
        
    }
    
    func getInfor() async throws {
        
        let urlString = Constants.baseURL + Endpoints.info
        guard let url = URL(string: urlString) else {
            throw httpError.badURL
        }
        
        let infoResponse: InforResponse = try await HttpClient.shared.fetchDatawithToken(url: url, httpMethod: httpMethod.GET.rawValue, with: token)
        
        self.info = infoResponse.infor
        
    }
    
    func fetchPaymentMethod() async throws {
        
        let urlString = Constants.baseURL + Endpoints.paymentMethod
        
        guard let url = URL(string: urlString) else {
            throw httpError.badURL
        }
        
        let paymentmethodResponse: PaymentMethodResponse = try await HttpClient.shared.fetchDatawithToken(url: url, httpMethod: httpMethod.GET.rawValue, with: token)
        
        self.paymentMethod = paymentmethodResponse.payment_method
        
        DispatchQueue.main.async {
            self.defaultPaymentMethod = paymentmethodResponse.payment_method.first!
        }
        
    }
    
    func addToBill(billRequest: BillRequest) async throws {
        let urlString = Constants.baseURL + Endpoints.insertBill
        
        guard let url = URL(string: urlString) else {
            throw httpError.badURL
        }
        
        let billRequest: BillRequest = billRequest
        
        try await HttpClient.shared.sendDatawithToken(to: url, object: billRequest, httpMethod: httpMethod.POST.rawValue, with: token)
    }
    
    
    
    
}
