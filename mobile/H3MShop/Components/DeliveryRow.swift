//
//  DeliveryRow.swift
//  H3MShop
//
//  Created by Lê Văn Huy on 06/11/2022.
//

import SwiftUI

struct DeliveryRow: View {
    var name: String
    var price: Int
    var note: String
    var body: some View {
        HStack{
            Capsule().frame(width: 6)
                .padding(.trailing,-50)
                .foregroundColor(Color.orange)
                .frame(height:82)
            VStack(alignment: .leading){
                HStack{
                    Text(name)
                        .modifier(Fonts(fontName: .outfit_regular,
                                        colorName: .black,
                                        size: 20))
                    Text("đ\(price)")
                        .modifier(Fonts(fontName: .outfit_regular,
                                        colorName: .red,
                                        size: 20))
                    Spacer()
                    
                }
                Text("Receive: \(note)")
                    .modifier(Fonts(fontName: .outfit_regular,
                                    colorName: .gray,
                                    size: 18))
            }
            .padding()
            .overlay(Rectangle()
                .stroke(lineWidth: 0.5))
            .background(Color(ColorsName.white.rawValue))
        }
    }
}

struct DeliveryRow_Previews: PreviewProvider {
    static var previews: some View {
        DeliveryRow(name: "Nhanh", price: 100000, note: "4-5 ngay")
    }
}
