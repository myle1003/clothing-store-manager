//
//  Authentication.swift
//  H3MShop
//
//  Created by Lê Văn Huy on 31/10/2022.
//

import Foundation
import SwiftUI

class Authentincation: ObservableObject {
    
    @AppStorage("token") var token: String = ""
    @Published var currenUser : User? = User()
    
    
    @Published var fullname: String = ""
    @Published var phone: String = ""
    @Published var gender: Bool = true
    @Published var resetRespond: ResetPasswordRespond = ResetPasswordRespond()
    
    init() {
        self.getUser()
    }
    
    
    func fetchUser() async throws -> User?{
        let urlString = Constants.baseURL + Endpoints.user
        
        guard let url = URL(string: urlString) else {
            throw httpError.badURL
        }
        
        let userResponse: GetUserResponse = try await HttpClient.shared.fetchDatawithToken(url: url, httpMethod: httpMethod.GET.rawValue, with: token)
        
        return userResponse.user
        
    }
    
    func editProfile() async throws {
        
        let urlString = Constants.baseURL + Endpoints.user
        guard let url = URL(string: urlString) else {
            throw httpError.badURL
        }
        
        let userToUpdate = UserRequest(fullname: fullname, phone: phone, gender: gender)
        
        try await HttpClient.shared.sendDatawithToken(to: url, object: userToUpdate, httpMethod: httpMethod.PUT.rawValue, with: token)
        
    }
    

    
    func getUser(){
        Task{
            do{
                let existedUser = try await self.fetchUser()
                DispatchQueue.main.async{
                    self.currenUser = existedUser
                    if self.currenUser != nil {
                        self.fullname = self.currenUser!.fullname
                        self.phone = self.currenUser!.phone
                        self.gender = self.currenUser!.gender
                    }
                }
            }
            catch{
                
            }
        }
        
    }
    
    func resetPassword(current_password: String,newPassword: String,confirmNewPassword: String) async throws  -> ResetPasswordRespond{
        let urlString = Constants.baseURL + Endpoints.resetPass
        
        guard let url = URL(string: urlString) else {
            throw httpError.badResponse
        }
        
        let resetPassRequest = ResetPasswordRequest(current_password: current_password, password: newPassword, password2: confirmNewPassword)
    
        return try await HttpClient.shared.checkResetPass(to: url, object: resetPassRequest, httpMethod: httpMethod.POST.rawValue, with: token)
    }
    


    
}

