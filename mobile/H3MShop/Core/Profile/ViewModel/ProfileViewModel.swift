//
//  ProfileViewModel.swift
//  H3MShop
//
//  Created by Lê Văn Huy on 31/10/2022.
//

import Foundation


enum StatsFillerViewModel: Int,CaseIterable {
    
    case toPay
    case toShip
    case toReceive
    case toComplete
    
    var title: String{
        switch self {
        case .toPay:
            return "To Pay"
        case .toShip:
            return "To Ship"
        case .toReceive:
            return "To Receive"
        case .toComplete:
            return "Completed"
        }
    }
}

class ProfileViewModel: ObservableObject {
      
}
