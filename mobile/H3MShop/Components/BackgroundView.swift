//
//  BackgroundView.swift
//  H3MShop
//
//  Created by Van Huy on 12/10/2022.
//

import SwiftUI

struct BackgroundView: View {
    var title: String
    var descrip: String
    var customSize = CustomSize()
    
    var body: some View {
        
        VStack(){
            
            HeaderView(title: title, descrip: descrip )
            
            nameShop
                .offset(x:0,y:-10)
            
        }
    }
}

struct BackgroundView_Previews: PreviewProvider {
    static var previews: some View {
        BackgroundView(title: "Login Account", descrip: "Welcome back to H3M Shop")
    }
}
extension BackgroundView {
    
    
    var nameShop: some View {
        HStack{
            Text("H3M")
                .modifier(Fonts(fontName: .outfit_bold,
                                colorName: .black,
                                size: customSize.nameShopSize))
            Text("Shop")
                .modifier(Fonts(fontName: .outfit_extraBold,
                                colorName: .purple,
                                size: customSize.nameShopSize))
        }
        .padding(.top,70)
    }
}
