//
//  Logo.swift
//  H3MShop
//
//  Created by Lê Văn Huy on 01/11/2022.
//

import SwiftUI

struct Logo: View {
    var customSize = CustomSize()
    var body: some View {
        VStack{
                Image("Main.logo")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .cornerRadius(30)
            
            VStack{
                Text("from")
                    .modifier(Fonts(fontName: .outfit_regular, colorName: .gray, size: 20))
                Text("H3M Group")
                    .modifier(Fonts(fontName: .outfit_bold, colorName: .purple, size: 28))
            }
            .offset(y:180)
            
        }
        .ignoresSafeArea()
        
    }
}

struct Logo_Previews: PreviewProvider {
    static var previews: some View {
        Logo()
    }
}
