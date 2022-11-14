//
//  SearchBarView.swift
//  H3MShop
//
//  Created by Van Huy on 15/10/2022.
//

import SwiftUI

struct SearchBarView: View {
    @Binding var text: String
    
    var customSize = CustomSize()
    
    var body: some View {
        VStack{
            TextField("Search",text: $text)
                .padding(.horizontal,30)
                .modifier(Fonts(fontName: .outfit_thin,
                                colorName: .gray,
                                size: customSize.textField))
                .frame(height:customSize.textField)
                .padding()
                .overlay(
                    HStack{
                        Image(systemName: "magnifyingglass")
                            .modifier(Fonts(fontName: .outfit_thin,
                                            colorName: .gray,
                                            size: customSize.textField))
                            .padding()
                        Spacer()
                    }
                        .padding(2)
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(lineWidth:0.8)
                )
            
        }
        .padding()
    }
}

struct SearchBarView_Previews: PreviewProvider {
    static var previews: some View {
        SearchBarView(text: .constant(""))
    }
}
