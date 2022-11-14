//
//  DetaiViewModel.swift
//  H3MShop
//
//  Created by Van Huy on 18/10/2022.
//

import Foundation
import SwiftUI

class DetailViewModel: ObservableObject {
    
    //Animation Property
    @Published var startAnimation = false
    @Published var shoesAnimation = false
    
    @Published var showBag = false
    @Published var saveCart = false
    @Published var addItemToCart = false
    @Published var endAnimation = false
    
    @Published var productDetail = ProductDetail(product: Product(_id: "", name: "", rate: 0, status: "", slug: "", urlImage: [], sold: 0, id_cate: "", size: [], color: [], description: "", price: 0, sellDay: "", weight: 0, discount: 0),number: [],comment: [],rate: Rate())
    
    //Perform Animations
    func performAnimation(){
        withAnimation(.easeInOut(duration:0.8)){
            shoesAnimation.toggle()
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.35){
            withAnimation(.easeInOut){
                self.showBag.toggle()
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.75){
            withAnimation(.easeInOut(duration:0.5)){
                self.saveCart.toggle()
            }
        }
        //0.35+ 0.75 = 1.25
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.1){
            self.addItemToCart.toggle()
        }
        
        //end Animation
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.25){
            withAnimation(.easeInOut(duration:0.5)){
                self.endAnimation.toggle()
            }
        }
    }
    
    func resetAll(){
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3){ [self] in
                
            withAnimation {
                self.startAnimation = false
            }
                endAnimation = false
                addItemToCart = false
                showBag = false
                shoesAnimation = false
                saveCart = false
            
        }
    }
    
        func fetchProductDetail(slug: String) async throws {

            
            let urlString = Constants.baseURL + Endpoints.productDetail + "/\(slug)"
            
            print(urlString)
    
            guard let url = URL(string: urlString) else {
                throw httpError.badURL
            }
    
            let responseProductDetail : ProductDetail = try await HttpClient.shared.fetch(url: url)
    
    
            DispatchQueue.main.async{
                self.productDetail = responseProductDetail
            }
            
            
        }
    
    
}


