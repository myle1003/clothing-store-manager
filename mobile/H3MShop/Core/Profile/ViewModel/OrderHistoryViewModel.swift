//
//  OrderHistoryViewModel.swift
//  H3MShop
//
//  Created by Lê Văn Huy on 10/11/2022.
//

import Foundation
import SwiftUI

enum StatsFillerViewModel: Int,CaseIterable {
    
    case toCheck
    case toRepair
    case toShip
    case toComplete
    case review
    
    var title: (String,Int){
        switch self {
        case .toCheck:
            return ("To Check",1)
        case .toRepair:
            return ("To Repair",2)
        case .toShip:
            return ("To Ship",3)
        case .toComplete:
            return ("Completed",4)
        
        case .review:
            return ("Review",5)
        }
    }
}

class OrderHistoryViewModel: ObservableObject{
    
    @AppStorage("token") var token: String = ""
    
    @Published var bills = [Bill]()
    @Published var type = 1
    
    init() {
        Task{
            do{
                DispatchQueue.main.async {
                    self.type = 1
                }
                try await self.fetchBill()
            }
        }
    }
    
    func fetchBill() async throws {
        
        
        let urlString = Constants.baseURL + Endpoints.getbills + "\(type)"
        
        guard let url = URL(string: urlString) else {
            throw httpError.badURL
        }
        
        let billReponse: BillResponse = try await HttpClient.shared.fetchDatawithToken(url: url, httpMethod: httpMethod.GET.rawValue, with: token)
        
        
        DispatchQueue.main.async {
            self.bills = billReponse.bill
        }
    }
    
    
}
