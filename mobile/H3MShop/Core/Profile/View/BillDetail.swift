//
//  BillDetail.swift
//  H3MShop
//
//  Created by Lê Văn Huy on 13/11/2022.
//

import SwiftUI

struct BillDetail: View {
    var bill: Bill
    var customSize = CustomSize()
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack{
            header
            Spacer()
            VStack{
                ScrollView{
                    Capsule()
                        .frame(height:3)
                        .foregroundColor(Color.green.opacity(0.8))
                    delivery
                    
                    
                    Capsule()
                        .frame(height:3)
                        .foregroundColor(Color.green.opacity(0.8))
                    
                    shipping
                    
                    Capsule()
                        .frame(height:3)
                        .foregroundColor(Color.green.opacity(0.8))
                    
                    listProduct
                    
                    
                    total
                    
//                    shipping
                }
            }
        }
        .navigationBarHidden(true)
    }
}

//struct BillDetail_Previews: PreviewProvider {
//    static var previews: some View {
//        BillDetail()
//    }
//}

extension BillDetail{
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
            Text("Bill Detail ")
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
                        Text(bill.id_bill.id_info.name)
                        Text("|")
                        Text(bill.id_bill.id_info.phone)
                    }
                    Text(bill.id_bill.id_info.address.street)
                    Text("\(bill.id_bill.id_info.address.id_commune.name),\(bill.id_bill.id_info.address.id_district.name),\(bill.id_bill.id_info.address.id_province.name)")
                }
                .modifier(Fonts(fontName: .outfit_regular,
                                colorName: .black,
                                size: 16))
                .padding(.leading)
                Spacer()
            }
            }
    }
    
    var listProduct: some View {
        VStack{
            ForEach(bill.id_bill.product){ product in
                CheckOutRow(urlImage: product.id_product.urlImage[0],
                            name: product.id_product.name,
                            color: product.color.name,
                            size: product.size.name,
                            price: product.price, quantity: product.number)
            }
        }
    }
    
    
    var shipping: some View{
        VStack(alignment: .leading){
            HStack{
                Image("Profile.Delivery")
                    .resizable()
                    .frame(width: 30,height: 30)
                Text("Shipping Information")
                    .modifier(Fonts(fontName: .outfit_regular,
                                    colorName: .black,
                                    size: 18))
                Spacer()
            }
            HStack{
                Text(bill.id_bill.delivery.name)
                Spacer()
                
            }
            .modifier(Fonts(fontName: .outfit_regular,
                            colorName: .black,
                            size: 16))
        
            
            VStack(alignment: .leading){
                Text(bill.history.last!.id_status.name)
                    .modifier(Fonts(fontName: .outfit_regular,
                                    colorName: .gray,
                                    size: 14))
                Text(bill.history.last!.date)
                    .modifier(Fonts(fontName: .outfit_regular,
                                    colorName: .gray,
                                    size: 12))
            }
            .padding(.top,1)
            
            
        }
        .modifier(Fonts(fontName: .outfit_regular,
                        colorName: .gray,
                        size: 18))
        .padding()
        .background(Color(ColorsName.white.rawValue).opacity(0.1))
    }
    
    var total: some View {
        VStack(alignment: .leading){
            HStack{
                Text("Order total:( \(bill.id_bill.product.count) Items)")
                Spacer()
                Text("đ \(bill.id_bill.productPrice)")
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
                Text("đ \(bill.id_bill.productPrice)")
            }
            HStack{
                Text("Shipping")
                Spacer()
                Text("đ\(bill.id_bill.shipPrice)")
            }
            HStack{
                Text("Total Payment")
                Spacer()
                Text("đ \(bill.id_bill.totalPrice)")
            }

            
        }
        .modifier(Fonts(fontName: .outfit_regular,
                        colorName: .black,
                        size: 18))
        .padding()
        .background(Color(ColorsName.white.rawValue))
    }
    
}
