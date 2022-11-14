//
//  CheckOutRow.swift
//  H3MShop
//
//  Created by Lê Văn Huy on 06/11/2022.
//

import SwiftUI
import Kingfisher
struct CheckOutRow: View {
    var urlImage: String
    var name: String
    var color: String
    var size: String
    var price: Int
    var quantity: Int
    var body: some View {
        VStack(alignment: .leading){
            HStack(alignment: .top){
                KFImage(URL(string: urlImage))
                    .resizable()
                    .frame(width: 100,height:100)
                VStack(alignment: .leading){
                    Text(name)
                    HStack{
                        Text("Color: \(color)")
                        Text("Size: \(size)")
                        
                    }
                    .modifier(Fonts(fontName: .outfit_regular,
                                    colorName: .gray,
                                    size: 16))
                    Spacer()
                    HStack{
                        Text("đ \(price)")
                            .modifier(Fonts(fontName: .outfit_regular,
                                            colorName: .black,
                                            size: 20))
                        Spacer()
                        Text("x\(quantity)")
                    }
                }
                .frame(height: 100)
                .modifier(Fonts(fontName: .outfit_regular,
                                colorName: .black,
                                size: 16))
                Spacer()
            }
        }
        .padding()
        .background(Color(ColorsName.gray.rawValue).opacity(0.1))
    }
}

struct CheckOutRow_Previews: PreviewProvider {
    static var previews: some View {
        CheckOutRow(urlImage: "test", name: "Quần nỉ ống suông Tăm cao cấp Unisex Local Brand", color: "Red", size: "M", price: 100000, quantity: 10)
    }
}
