//
//  ProductView.swift
//  H3MShop
//
//  Created by Van Huy on 15/10/2022.
//

import SwiftUI
import Kingfisher
struct ProductView: View {
    
    var customSize = CustomSize()
    
    var name: String
    var category: String
    var urlImage: String
    var price: Int
    var discount: Int
    var sold: Int
    
    var body: some View {
        VStack(){
            
            imageProduct
           
            
            detailProduct
            
        }
        .frame(width: customSize.widthRowProduct,
               height: 320)
        .background(Color(ColorsName.white.rawValue))
        .overlay(Rectangle()
            .stroke()
            .foregroundColor(Color.gray.opacity(0.6))
        
        )
    }
}

struct ProductView_Previews: PreviewProvider {
    static var previews: some View {
        ProductView(name: "Men's Shoes", category: "Energy Runner LP", urlImage: "https://i1-dulich.vnecdn.net/2020/09/04/1-Meo-chup-anh-dep-khi-di-bien-9310-1599219010.jpg?w=680&h=0&q=100&dpr=2&fit=crop&s=efAtSBQa53IMrnw7tVfj8A", price: 20,discount: 15, sold: 10)
    }
}
extension ProductView{
    var imageProduct: some View {
        KFImage(URL(string: urlImage))
            .resizable()
            .frame(width:customSize.imageWidthProduct,
                   height:customSize.imageHeightProduct)
            .padding(.bottom)
            .overlay(
                VStack{
                    Image(discount != 0 ? "discount" : "")
                        .resizable()
                        .frame(width: 35,height: 40)
                        
                    
                }
                    .offset(x:74,y:-84)
                    
                
            )

    }
    
    var detailProduct: some View {
        VStack(alignment: .leading,spacing: 1){
            Text(name)
                .modifier(Fonts(fontName: .outfit_regular,
                                colorName: .productCategory,
                                size: 18))
            Text(category)
                .modifier(Fonts(fontName: .outfit_regular,
                                colorName: .black,
                                size: 16))
            Image("ticket")
                .resizable()
                .frame(width:40,height: 30)
                .overlay(
                    Text("\(discount)% OFF")
                        .modifier(Fonts(fontName: .outfit_regular,
                                        colorName: .red,
                                        size: 6))
                )
            
            
            HStack{
                Text("\(price)đ")
                    .modifier(Fonts(fontName: .outfit_regular,
                                    colorName: .red,
                                    size: customSize.textLoginSize))
                
                Spacer()
                
                Text("Sold: \(sold)")
                    .modifier(Fonts(fontName: .outfit_regular,
                                    colorName: .black,
                                    size: customSize.textLoginSize))
                
                
            }
            .offset(y:8)
            
        }
        .offset(y:-20)
        .padding(.leading)
        .padding(.trailing)
    }
}
