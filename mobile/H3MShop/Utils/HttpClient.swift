//
//  HttpClient.swift
//  H3MShop
//
//  Created by Van Huy on 21/10/2022.
//

import Foundation
import SwiftUI

enum httpError: Error {
    case badURL,badResponse,errorDecodingData,invalidURL
}

enum httpMethod: String {
    case POST,GET,PUT,DELETE
}

enum MIMEType: String {
    case JSON = "application/json"
}

enum httpHeaders: String {
    case contentType = "Content-Type"
    case authorization = "Authorization"
    case token = "token"
}

class HttpClient{
    
    private init(){
        
    }
    
    static let shared = HttpClient()
    
    
    func fetch<T:Codable>(url: URL) async throws -> T {
        
        let (data,response) = try await URLSession.shared.data(from: url)
        
        guard (response as? HTTPURLResponse)?.statusCode == 200  else {
            throw httpError.badResponse
        }
        
        guard let object = try? JSONDecoder().decode(T.self, from: data) else {
            print("ERROR DECODE DATA")
            throw httpError.errorDecodingData
        }
        
        return object
        
    }
    
    
    
    func checkLoginAPI<T:Codable,K: Codable>(to url: URL,object: T, httpMethod: String) async throws -> K {
        
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod
        request.addValue(MIMEType.JSON.rawValue,
                         forHTTPHeaderField: httpHeaders.contentType.rawValue)
        
        request.httpBody = try? JSONEncoder().encode(object)
        
        
        let (data,response) = try await URLSession.shared.data(for: request)
        
        
        guard (response as? HTTPURLResponse)?.statusCode == 200 || (response as? HTTPURLResponse)?.statusCode == 400 else {
            print("Bad ERROR")
            throw httpError.badResponse
            
           
        }
        
        
        guard let check = try? JSONDecoder().decode(K.self, from: data) else{
            print("ERROR DECODE DATA")
            throw httpError.errorDecodingData
        }
        return check
    }
    
    
    func sendData<T:Codable>(to url: URL,object: T, httpMethod: String) async throws  {
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod
        request.addValue(MIMEType.JSON.rawValue,
                         forHTTPHeaderField: httpHeaders.contentType.rawValue)
        
        request.httpBody = try? JSONEncoder().encode(object)
        
        let (_,response) = try await URLSession.shared.data(for: request)
        
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            throw httpError.badResponse
        }
    }
    
    
    func deleteData(url: URL,httpMethod: String, with token: String) async throws {
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod
        request.setValue(token, forHTTPHeaderField: httpHeaders.token.rawValue)
        let (_,response) = try await URLSession.shared.data(for: request)
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            throw httpError.badResponse
        }
    }
    
    
    func fetchDatawithToken<T:Codable>(url: URL,httpMethod: String,with token: String)  async throws -> T {
        
        var request = URLRequest(url:url)
        
        request.httpMethod = httpMethod
        request.setValue(token, forHTTPHeaderField: httpHeaders.token.rawValue)
        
        
        let (data,response) = try await URLSession.shared.data(for: request)
        
        guard (response as? HTTPURLResponse)?.statusCode == 200 || (response as? HTTPURLResponse)?.statusCode == 401 else {
            throw httpError.badResponse
        }

        guard let object = try? JSONDecoder().decode(T.self, from: data) else {
            print("ERROR DECODE DATA")
            throw httpError.errorDecodingData
        }
        
        return object
    }
    
    
    func sendDatawithToken<T:Codable>(to url: URL,object: T, httpMethod: String,with token: String) async throws {
        var request = URLRequest(url: url)
        
        request.httpMethod = httpMethod
        
        request.addValue(MIMEType.JSON.rawValue,
                         forHTTPHeaderField: httpHeaders.contentType.rawValue)
        
        request.setValue(token, forHTTPHeaderField: httpHeaders.token.rawValue)
        
        request.httpBody = try? JSONEncoder().encode(object)
        
        
        let (_,response) = try await URLSession.shared.data(for: request)
        
        
        guard (response as? HTTPURLResponse)?.statusCode == 200 || (response as? HTTPURLResponse)?.statusCode == 401 else {
            throw httpError.badResponse
        }
    }
    
}
