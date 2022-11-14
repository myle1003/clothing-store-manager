//
//  LoginViewModel.swift
//  H3MShop
//
//  Created by Lê Văn Huy on 26/10/2022.
//

import Foundation
import SwiftUI
class LoginViewModel: ObservableObject {
    
    
    @Published var email = ""
    @Published var password = ""
    
    @Published var isFocusEmail = false
    @Published var isValidEmail = false
    @Published var isEmptyField = false
    @Published var isRightAllField = true
    
    @Published var response: LoginResponse =  LoginResponse()
    
    func login() async throws -> LoginResponse {
        let urlString = Constants.baseURL + Endpoints.login
        
        guard let url = URL(string: urlString) else {
            throw httpError.badResponse
        }
        
        let loginRequest = LoginRequest(email: email, password: password)
    
        return try await HttpClient.shared.checkLoginAPI(to: url, object: loginRequest, httpMethod: httpMethod.POST.rawValue)
        
    }
    
    
    //MARK: Validate email address logic
    func isValidEmails() -> Bool {
        if email.count > 100 {
            return false
        }
        let emailFormat = "(?:[\\p{L}0-9!#$%\\&'*+/=?\\^_`{|}~-]+(?:\\.[\\p{L}0-9!#$%\\&'*+/=?\\^_`{|}" + "~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\" + "x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[\\p{L}0-9](?:[a-" + "z0-9-]*[\\p{L}0-9])?\\.)+[\\p{L}0-9](?:[\\p{L}0-9-]*[\\p{L}0-9])?|\\[(?:(?:25[0-5" + "]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-" + "9][0-9]?|[\\p{L}0-9-]*[\\p{L}0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21" + "-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailFormat)
        return emailPredicate.evaluate(with: email)
    }
    
    func isEmptyFields() -> Bool {
        if (email == "") || (password == "") {
            return true
        }
        return false
    }
    
    func isRightAllFields() -> Bool {
        if isValidEmails() && (password != "")  {
            return true
        }
        return false
    }
    

}
