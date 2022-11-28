//
//  CheckoutView.swift
//  H3MShop
//
//  Created by Van Huy on 18/10/2022.
//

import SwiftUI

struct CheckoutView: View {
    
    var customSize = CustomSize()
    
    @StateObject var vmAddress = MyAddressViewModel()
    @Environment(\.presentationMode) var presentationMode
    @StateObject var vmCart = CartViewModel()
    @StateObject var vm = CheckOutViewModel()
    @State var load = true
    @State var isCheck = false
    
    
    var body: some View {
        VStack(alignment: .leading){
            
            if !load{
                Loader()
            }
            else{
                VStack{
                    header
                    VStack{
                        ScrollView{
                            NavigationLink(destination: AddressView( infoAddress: $vmAddress.defaultAddress)) {
                                delivery
                            }
                            Capsule()
                                .frame(height:3)
                                .foregroundColor(Color.green.opacity(0.8))
                            listProduct

                            NavigationLink(destination: ShippingView(delivery: $vm.defaultDelivery)) {
                                shipping
                            }
                            
                            total
                            
                        }
                    }
                    Spacer()
                }
                
                VStack{
                    HStack{
                        
                        VStack(alignment: .leading){
                            Text("Total Payment")
                                .modifier(Fonts(fontName: .outfit_regular,
                                                colorName: .black,
                                                size: 20))
                            Text("đ \(vmCart.carts.price + vm.defaultDelivery.price)")
                                .modifier(Fonts(fontName: .outfit_regular,
                                                colorName: .red,
                                                size: 20))
                                .padding(.bottom)
                        }
                        Spacer()
                        
                        
                        NavigationLink("", destination: WaitToCheck(), isActive: self.$isCheck)
                        
                        Button {
                            Task{
                                do{
                                    let productsBill = vmCart.getProductBill()
                                    
                                    let billRequest: BillRequest = BillRequest(product: productsBill, payment_method: vm.defaultPaymentMethod._id, delivery: vm.defaultDelivery._id, weight: 0.5, productPrice: vmCart.carts.price, shipPrice: vm.defaultDelivery.price, id_info: vmAddress.defaultAddress._id)
                                    try await vm.addToBill(billRequest: billRequest)
                                    self.isCheck = true
                                }
                                catch{
                                    
                                }
                            }
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
            
            
            

            
        }
        .navigationBarHidden(true)
        .background(Color(ColorsName.white.rawValue).opacity(0.05))
    }
}

struct CheckoutView_Previews: PreviewProvider {
    static var previews: some View {
        CheckoutView()
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
                        Text(vmAddress.defaultAddress.name)
                        Text("|")
                        Text(vmAddress.defaultAddress.phone)
                    }
                    Text(vmAddress.defaultAddress.address.street)
                    Text("\(vmAddress.defaultAddress.address.id_commune.name),\(vmAddress.defaultAddress.address.id_district.name),\(vmAddress.defaultAddress.address.id_province.name)")
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
            ForEach(vmCart.carts.cart.product){ product in
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
                Text(vm.defaultDelivery.name)
                Spacer()
                Text("đ\(vm.defaultDelivery.price)")
                Image("Profile.next")
                    .resizable()
                    .frame(width: 15,height:15)
            }
            .modifier(Fonts(fontName: .outfit_regular,
                            colorName: .black,
                            size: 16))
            Text("Receive by \(vm.defaultDelivery.note)")
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
                Text("đ \(vmCart.carts.price)")
            }
            
            Divider()
            
            NavigationLink {
                PaymentView(paymentMethod: $vm.defaultPaymentMethod)
            } label: {
                HStack{
                Image("dollar")
                        .resizable()
                        .frame(width: 25,height: 25)
                Text("Payment Option")
                
                Spacer()
                    Text(vm.defaultPaymentMethod.name)
                    Text(vm.defaultPaymentMethod.card!.isEmpty ? "" : "[\(vm.defaultPaymentMethod.card!.first!.bank)]")
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
                Text("đ \(vmCart.carts.price)")
            }
            HStack{
                Text("Shipping")
                Spacer()
                Text("đ\(vm.defaultDelivery.price)")
            }
            HStack{
                Text("Total Payment")
                Spacer()
                Text("đ \(vmCart.carts.price + vm.defaultDelivery.price)")
            }

            
        }
        .modifier(Fonts(fontName: .outfit_regular,
                        colorName: .black,
                        size: 18))
        .padding()
        .background(Color(ColorsName.white.rawValue))
    }
}
