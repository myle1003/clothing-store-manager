//
//  CartView.swift
//  H3MShop
//
//  Created by Van Huy on 17/10/2022.
//

import SwiftUI

struct CartView: View {
    
    @EnvironmentObject var authViewModel : Authentincation
    @Environment(\.presentationMode) var presentationMode
    
    var customSize = CustomSize()
    var body: some View {
        VStack{
            header
            
            listCart
            
            Spacer()
            
            addtoCart
            
            
            
        }
        .background(Color(ColorsName.white.rawValue).opacity(0.05))
        .navigationBarHidden(true)
    }
}

struct CartView_Previews: PreviewProvider {
    static var previews: some View {
        CartView()
            .environmentObject(Authentincation())
    }
}

extension CartView {
    var header: some View {
        HStack{
            Button {
                //MARK: GO TO MAIN
                presentationMode.wrappedValue.dismiss()
            } label: {
                Image("Main.back")
                    .resizable()
                    .frame(width: customSize.mainButtonDetail,
                           height: customSize.mainButtonDetail)
            }
            
            Spacer()
            Text("My Cart")
                .modifier(Fonts(fontName: .outfit_regular,
                                colorName: .black,
                                size: customSize.heightButtonList))
            Spacer()
            Button {
                //MARK: GO TO TRASH
            } label: {
                Image("Main.Trash")
                    .resizable()
                    .frame(width: customSize.mainButtonDetail,
                           height: customSize.mainButtonDetail)
            }
            
            
        }
        .padding(.leading)
        .padding(.trailing)
    }
    
    var listCart: some View {
        ScrollView(){
            ForEach(authViewModel.carts.cart.product){ product in
                
                withAnimation(.spring()){
                    RowCartView(id_product: product._id, urlImage: product.id_product.urlImage[0], name: product.id_product.name,
                                color: product.color.name,
                                size: product.size.name,
                                discount: product.id_product.discount, price: product.id_product.price - (product.id_product.price * product.id_product.discount)/100, quantity: product.number)
                }
                
            }
            
        }
        .frame(height:customSize.scrollCartSize)
    }
    
    var addtoCart: some View {
        HStack{
            VStack(alignment: .leading){
                Text("Total price: ")
                    .modifier(Fonts(fontName: .outfit_bold,
                                    colorName: .black,
                                    size: 23))
                Text("\(Int(authViewModel.carts.price))đ")
                    .modifier(Fonts(fontName: .outfit_regular,
                                    colorName: .red,
                                    size: 23))
            }
            
            Spacer()
            
            NavigationLink(destination: CheckoutView()) {
                HStack{
                    Image("Cart.Checkout")
                        .resizable()
                        .frame(width:35,height:35)
                    Text("Check out")
                        .modifier(Fonts(fontName: .outfit_bold,
                                        colorName: .white,
                                        size: 23))
                }
                .frame(width:170,
                       height:55)
                .background(                                LinearGradient(colors: [Color(ColorsName.purple.rawValue),Color(ColorsName.blue.rawValue)], startPoint: .top, endPoint: .bottom))
                .cornerRadius(15)
            }
            
        }
        .padding(.leading)
        .padding(.trailing)
        .offset(y:-24)
    }
}
