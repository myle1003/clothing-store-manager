//
//  MainViewModel.swift
//  H3MShop
//
//  Created by Van Huy on 22/10/2022.
//

import Foundation

class MainViewModel: ObservableObject {
    
    @Published  var categories = [Category]()
    @Published var products = [Product]()
    @Published var totalCount = 1
    @Published var recentCount = 1
    @Published var slug = ""
    @Published var textSearch = ""
    
    init(){
        self.getProducts()
        self.getCategories()
    }
    
    func fetchCategories() async throws  -> [Category]{
        
        let urlString = Constants.baseURL + Endpoints.categories
        
        guard let url = URL(string: urlString) else {
            throw httpError.badURL
        }
        
        let categoriesResponse: [Category] = try await HttpClient.shared.fetch(url: url)
        
        return categoriesResponse

    }
    
    func fetchProducts() async throws -> [Product]{
        let urlString = Constants.baseURL + Endpoints.products + "\(recentCount)"
        
        guard let url = URL(string: urlString) else {
            throw httpError.badURL
        }
        let productsResponse: MainProduct = try await HttpClient.shared.fetch(url: url)
        
        DispatchQueue.main.async {
            self.totalCount = productsResponse.count
        }
        
        return productsResponse.products
    }
    
    func fetchMoreProduct() async throws {
        let urlString = Constants.baseURL + Endpoints.products + "\(recentCount)"
        
        guard let url = URL(string: urlString) else {
            throw httpError.badURL
        }
        let productsResponse: MainProduct = try await HttpClient.shared.fetch(url: url)
        
        DispatchQueue.main.async {
            self.products += productsResponse.products
        }

    }
    
    func getProducts() {
        Task{
            do {
                let existedProducts: [Product] = try await fetchProducts()
                DispatchQueue.main.async{
                    self.products = existedProducts
                }
            }
            catch{
                
            }
        }
    }
    
    func getCategories() {
        Task{
            do {
                let existedCategories: [Category] = try await fetchCategories()
                DispatchQueue.main.async{
                    self.categories = existedCategories
                }
            }
            catch{
                
            }
        }
    }
    
    func fetchProductbyCategories(slug: String) async throws -> [Product]  {
        
        DispatchQueue.main.async {
            self.slug = slug
        }
        
        let urlString = Constants.baseURL + Endpoints.productsbyCategory + "list/\(slug)/1"
        guard let url = URL(string: urlString) else {
            throw httpError.badURL
        }
        
        let productsResponse: MainProduct = try await HttpClient.shared.fetch(url: url)
        
        DispatchQueue.main.async {
            self.totalCount = productsResponse.count
        }
        
        return productsResponse.products
        

    }
    
    func getProductbyCategory(slug: String) {
        Task{
            do{
                let products = try await fetchProductbyCategories(slug: slug)
                DispatchQueue.main.async {
                    self.products = products
                }
            }
            catch{
                
            }
        }
    }
    
}
