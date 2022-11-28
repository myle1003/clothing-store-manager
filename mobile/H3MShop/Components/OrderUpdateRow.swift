//
//  OrderUpdateRow.swift
//  H3MShop
//
//  Created by Van Huy on 18/10/2022.
//

import SwiftUI

struct OrderUpdateRow: View {
    var image: String
    var title: String
    var descrip: String
    var body: some View {
        VStack{
            HStack(){
                Image(image)
                    .resizable()
                    .frame(width:70,height:50)
                    .overlay(Rectangle()
                        .stroke(lineWidth: 0.3)
                        .frame(width:65,height:65)
                    )
                VStack(alignment: .leading){
                    Text(title)
                        .modifier(Fonts(fontName: .outfit_regular,
                                        colorName: .black,
                                        size: 20))
                        .padding(.bottom,2)
                    Text(descrip)
                        .lineLimit(2)
                        .modifier(Fonts(fontName: .outfit_regular,
                                        colorName: .black,
                                        size: 14))
                    Spacer()
                }
                .padding()
                
                Spacer()
                Button {
                    //MARK: LINK TO .....
                } label: {
                    Image(systemName: "chevron.right")
                        .font(.title3)
                        .foregroundColor(Color.black)
                        .padding()
                }
            }
            .padding(.leading)
            .frame(height:120)
            .background(Color.white)
            Divider()
                .frame(height:5)
                .padding(.top,-8)
        }
    }
}

struct OrderUpdateRow_Previews: PreviewProvider {
    static var previews: some View {
        OrderUpdateRow(image: "shoes1",
                       title: "Giao hàng thành công",
                       descrip: "Kiện hàng SPXVN02777850 của đơn hàng 2210 đã giao thành công đến bạn")
    }
}
