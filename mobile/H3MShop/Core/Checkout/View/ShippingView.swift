//
//  ShippingView.swift
//  H3MShop
//
//  Created by Lê Văn Huy on 06/11/2022.
//

import SwiftUI

struct ShippingView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var authViewModel: Authentincation
    var customSize =  CustomSize()
    @Binding var name: String
    @Binding var price: Int
    var body: some View {
        VStack(alignment: .leading){
            
            header
            
            ScrollView{
                VStack(alignment: .leading){
                    Text("H3M SHOP SUPPORTED LOGISTICS")
                        .modifier(Fonts(fontName: .outfit_regular,
                                        colorName: .gray,
                                        size: 18))
                    Text("H3M Supporyed Logistics allow you to track your order within H3M App")
                        .modifier(Fonts(fontName: .outfit_regular,
                                        colorName: .black,
                                        size: 16))
                }
                .padding()
                
                ForEach(authViewModel.delivery){ delivery in
                    Button {
                        self.name = delivery.name
                        self.price = delivery.price
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        DeliveryRow(name: delivery.name, price: delivery.price, note: delivery.note)
                    }

                }
               
            }
            
            Spacer()
        }
        .navigationBarHidden(true)
        .background(Color(ColorsName.white.rawValue).opacity(0.05))
    }
}

struct ShippingView_Previews: PreviewProvider {
    static var previews: some View {
        ShippingView(name: .constant(""), price: .constant(2))
            .environmentObject(Authentincation())
    }
}

extension ShippingView {
    var header: some View {
        HStack{
            
            
            Button {
                //MARK: GO TO PROFILE
                presentationMode.wrappedValue.dismiss()
            } label: {
                Image("Main.back")
                    .resizable()
                    .frame(width: customSize.mainButtonDetail,
                           height: customSize.mainButtonDetail)
            }
            Spacer()
            
            Text("Shipping Option")
                .modifier(Fonts(fontName: .outfit_regular,
                                colorName: .black,
                                size: customSize.heightButtonList))
                .offset(x:-28)
            Spacer()
            
            
        }
        .padding(.leading)
        .padding(.trailing)
    }
}
