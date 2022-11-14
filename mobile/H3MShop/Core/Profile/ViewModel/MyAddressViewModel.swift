//
//  MyAddressViewModel.swift
//  H3MShop
//
//  Created by Lê Văn Huy on 08/11/2022.
//

import Foundation
import SwiftUI
class MyAddressViewModel: ObservableObject{
    
    @AppStorage("token") var token: String = ""
    
    @Published var province = Province()
    @Published var district = District()
    @Published var commune  =  Commune()
    
    @Published var provinces = [Province]()
    @Published var districts = [District]()
    @Published var communes =  [Commune]()
    
    @Published var infoAddress = [InfoAddress]()
    
    @Published var defaultAddress: InfoAddress = InfoAddress()
    
    init(){
        self.getInforAddress()
        self.getProvince()
    }
    
    func fetchProvinces() async throws  -> [Province] {
        
        let urlString = Constants.baseURL + Endpoints.provinces
        
        guard let url = URL(string: urlString) else {
            throw httpError.badURL
        }
        
        let provincesResponse: [Province] = try await HttpClient.shared.fetchDatawithToken(url: url, httpMethod: httpMethod.GET.rawValue, with: token)
        
        
        return provincesResponse
        
    }
    
    func fetchDistricts(id_province: String) async throws -> [District] {
        
        let urlString = Constants.baseURL + Endpoints.districs + "/\(id_province)"
        
        guard let url = URL(string: urlString) else {
            throw httpError.badURL
        }
        
        let districsResponse: [District] = try await HttpClient.shared.fetchDatawithToken(url: url, httpMethod: httpMethod.GET.rawValue, with: token)
        
        return districsResponse
        
        
    }
    
    func fetchCommunes(id_district: String) async throws -> [Commune]{
        
        let urlString = Constants.baseURL + Endpoints.communes + "/\(id_district)"
        
        guard let url = URL(string: urlString) else {
            throw httpError.badURL
        }
        
        let communesResponse: [Commune] = try await HttpClient.shared.fetchDatawithToken(url: url, httpMethod: httpMethod.GET.rawValue, with: token)
        
        return communesResponse
        
    }
    
    
    func fetchInforAddress() async throws -> [InfoAddress] {
        let urlString = Constants.baseURL + Endpoints.inforaddress
        guard let url = URL(string: urlString) else {
            throw httpError.badURL
        }
        
        let infoAddressResponse: inforAddressResponse = try await HttpClient.shared.fetchDatawithToken(url: url, httpMethod: httpMethod.GET.rawValue, with: token)
        
        return infoAddressResponse.inforAddress
    }
    
    func getInforAddress() {
        
        Task{
            do{
                let existedInforAddress = try await fetchInforAddress()
                DispatchQueue.main.async {
                    self.defaultAddress = existedInforAddress.filter{$0.role == true}.first!
                }
                DispatchQueue.main.async {
                    self.infoAddress = existedInforAddress
                }
            }
        }
    }
    
    func addInforAddress(name: String,phone: String,address: Address,role: Bool) async throws {
        let urlString = Constants.baseURL + Endpoints.inforaddress
        guard let url = URL(string: urlString) else {
            throw httpError.badURL
        }
        
        let InfoAddressRequest = AddressRequest(name: name, phone: phone, address: address, role: role)
        
        try await HttpClient.shared.sendDatawithToken(to: url, object: InfoAddressRequest, httpMethod: httpMethod.POST.rawValue, with: token)
    }
    
    
    ///EDITTTTTTTTT
    func editInforAddress(name: String,phone: String,address: Address,role: Bool,id: String) async throws {
        let urlString = Constants.baseURL + Endpoints.inforaddress + "/\(id)"
        guard let url = URL(string: urlString) else {
            throw httpError.badURL
        }
        
        let InfoAddressRequest = AddressRequest(name: name, phone: phone, address: address, role: role)
        
        try await HttpClient.shared.sendDatawithToken(to: url, object: InfoAddressRequest, httpMethod: httpMethod.PUT.rawValue, with: token)
    }
    
    func deleteInforAddress(with id: String) async throws {
        let urlString = Constants.baseURL + Endpoints.inforaddress + "/\(id)"
        
        guard let url = URL(string: urlString) else {
            throw httpError.badURL
        }
        
        try await HttpClient.shared.deleteData(url: url, httpMethod: httpMethod.DELETE.rawValue, with: token)
        
        self.getInforAddress()
    }
    
    func getProvince(){
        Task {
            do{
                let existedProvinces: [Province] = try await self.fetchProvinces()
                
                DispatchQueue.main.async {
                    self.provinces = existedProvinces
                }
            }
        }
    }
    

    
    
    func getDistrict(id_province: String) async throws{
        
        let existedDistricts: [District] = try await self.fetchDistricts(id_province: id_province)
        DispatchQueue.main.async{
            self.districts = existedDistricts
            self.district = self.districts.first!
        }
    }
    
    func getCommune(id_district: String) async throws {
        let existedCommune: [Commune] = try await self.fetchCommunes(id_district: id_district)
        DispatchQueue.main.async{
            self.communes = existedCommune
            self.commune = self.communes.first!
            
        }
        
    }
    
//    func editAddress() async throws {
//        let urlString = Constants.baseURL + Endpoints.user
//        guard let url = URL(string: urlString) else {
//            throw httpError.badURL
//        }
//        
//        
//        
//        
//    }
    
}
