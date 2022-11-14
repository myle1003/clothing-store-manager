//
//  CheckoutView.swift
//  H3MShop
//
//  Created by Van Huy on 18/10/2022.
//

import SwiftUI

struct CheckoutView: View {
    
    var customSize = CustomSize()
    
    @EnvironmentObject var authViewModel: Authentincation
    @Environment(\.presentationMode) var presentationMode
    @State var ship: Int = 10000
    @State var name: String = "Giao hàng nhanh"
    @State var payment: String = "Cash on Delivery"
    
    
    var body: some View {
        VStack(alignment: .leading){
            header
            VStack{
                ScrollView{
                    NavigationLink(destination: ShoppingAddressView()) {
                        delivery
                    }
                    Capsule()
                        .frame(height:3)
                        .foregroundColor(Color.green.opacity(0.8))
                    listProduct

                    NavigationLink(destination: ShippingView(name: $name, price: $ship)) {
                        shipping
                    }
                    
                    total
                    
                }
            }
            Spacer()
            
            VStack{
                HStack{
                    
                    VStack(alignment: .leading){
                        Text("Total Payment")
                            .modifier(Fonts(fontName: .outfit_regular,
                                            colorName: .black,
                                            size: 20))
                        Text("đ \(authViewModel.carts.price + ship)")
                            .modifier(Fonts(fontName: .outfit_regular,
                                            colorName: .red,
                                            size: 20))
                            .padding(.bottom)
                    }
                    Spacer()
                    NavigationLink {
                        WaitToCheck()
                    } label: {
                        Text("Place Holder")
                            .modifier(Fonts(fontName: .outfit_bold,
                                            colorName: .white,
                                            size: 20))
                            .padding()
                            .frame(width: 180,height: 60)
                            .background(Color.orange)
                            .cornerRadius(20)
                    }


                }
                .padding(.leading)
                .padding(.trailing,20)
                .padding(.bottom,2)
                .padding(.top,2)
            }
            .background(Color(ColorsName.white.rawValue))
            .shadow(radius: 10)
            
            
            

            
        }
        .navigationBarHidden(true)
        .background(Color(ColorsName.white.rawValue).opacity(0.05))
    }
}

struct CheckoutView_Previews: PreviewProvider {
    static var previews: some View {
        CheckoutView()
            .environmentObject(Authentincation())
    }
}
extension CheckoutView {
    
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
            Text("Checkout ")
                .modifier(Fonts(fontName: .outfit_regular,
                                colorName: .black,
                                size: customSize.heightButtonList))
            Spacer()
            Button {
                //
            } label: {
                Image("")
                    .resizable()
                    .frame(width: customSize.mainButtonDetail,
                           height: customSize.mainButtonDetail)
            }
            
            
        }
        .padding(.leading)
        .padding(.trailing)
    }
    
    var delivery: some View {
        VStack(alignment: .leading){
            HStack{
                VStack(alignment: .leading){
                    HStack{
                        Image("Profile.location")
                            .resizable()
                            .frame(width: 20,height: 20)
                        Text("Delivery Address")
                    }
                    .modifier(Fonts(fontName: .outfit_regular,
                                    colorName: .black,
                                    size: 20))
                    HStack{
                        Text(authViewModel.fullname)
                        Text("|")
                        Text(authViewModel.phone)
                    }
                    Text(authViewModel.address.street)
                    Text("\(authViewModel.commune.name) Commune ,\(authViewModel.district.name) District , \(authViewModel.province.name) Province")
                }
                .modifier(Fonts(fontName: .outfit_regular,
                                colorName: .black,
                                size: 16))
                .padding(.leading)
                Spacer()
                Image("Profile.next")
                    .resizable()
                    .frame(width: 20,height:20)
                    .padding(.trailing)
            }
            }
    }
    var listProduct: some View {
        VStack{
            ForEach(authViewModel.carts.cart.product){ product in
                CheckOutRow(urlImage: product.id_product.urlImage[0], name: product.id_product.name, color: product.color.name, size: product.size.name, price: product.id_product.price, quantity: product.number)
            }
        }
    }
    var shipping: some View{
        VStack(alignment: .leading){
            Text("Shipping Option")
                .modifier(Fonts(fontName: .outfit_regular,
                                colorName: .green,
                                size: 18))
            Capsule()
                .frame(height:1)
                .foregroundColor(Color.gray.opacity(0.2))
            HStack{
                Text(name)
                Spacer()
                Text("đ\(ship)")
                Image("Profile.next")
                    .resizable()
                    .frame(width: 15,height:15)
            }
            .modifier(Fonts(fontName: .outfit_regular,
                            colorName: .black,
                            size: 16))
            Text("Receive by \(authViewModel.delivery.first!.note)")
            Text("Look for an applicable Voucher from H3M Shop")
        }
        .modifier(Fonts(fontName: .outfit_regular,
                        colorName: .gray,
                        size: 18))
        .padding()
        .background(Color(ColorsName.green.rawValue).opacity(0.1))
    }
    var total: some View {
        VStack(alignment: .leading){
            HStack{
                Text("Order total:(2 Items)")
                Spacer()
                Text("đ \(authViewModel.carts.price)")
            }
            
            Divider()
            
            NavigationLink {
                PaymentView(name: $payment)
            } label: {
                HStack{
                Image("dollar")
                        .resizable()
                        .frame(width: 25,height: 25)
                Text("Payment Option")
                
                Spacer()
                Text(payment)
                    Image("Profile.next")
                        .resizable()
                        .frame(width: 15,height:15)
                
                }
            }

            Divider()
            
            HStack{
                Image("bill")
                    .resizable()
                    .frame(width: 25,height: 25)
                Text("Payment Detail")
            }
            HStack{
                Text("Merchandise Subtotal")
                Spacer()
                Text("đ \(authViewModel.carts.price)")
            }
            HStack{
                Text("Shipping")
                Spacer()
                Text("đ\(ship)")
            }
            HStack{
                Text("Total Payment")
                Spacer()
                Text("đ \(authViewModel.carts.price + ship)")
            }

            
        }
        .modifier(Fonts(fontName: .outfit_regular,
                        colorName: .black,
                        size: 18))
        .padding()
        .background(Color(ColorsName.white.rawValue))
    }
}
