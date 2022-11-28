//
//  CategoryView.swift
//  H3MShop
//
//  Created by Van Huy on 15/10/2022.
//

import SwiftUI

struct CategoryView: View {
    
    var customSize = CustomSize()
    @Binding var indexImage: Int
    var index: Int
    var name: String
    
    var body: some View {
        VStack{
            HStack(){
                Circle()
                    .foregroundColor(Color(ColorsName.white.rawValue))
                    .frame(width:50,
                           height:50)
                    .padding()
                    .overlay(
                        HStack{
                            Image("Category\(index)")
                                .resizable()
                                .frame(width:35,
                                       height:35)
                                .padding()
                        }
                    )
                    .padding(.leading,-24)
                Text(name.uppercased())
                    .bold()
                    .modifier(Fonts(fontName: .outfit_bold, colorName: .black, size: 10))
                    .frame(height: 50)
                    .lineLimit(2)
                    .offset(x:-8)
                Spacer()
            }
            .padding()
        }
        .frame(width:customSize.widthCategory,
               height:customSize.heightCategory)
        .background(indexImage == index ? Color(ColorsName.listCategory.rawValue): Color(ColorsName.blue.rawValue).opacity(0.5))
        .cornerRadius(30)
    }
}

struct CategoryView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryView(indexImage: .constant(1), index: 1, name: "label")
    }
}
