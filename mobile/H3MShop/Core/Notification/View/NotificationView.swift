//
//  NotificationView.swift
//  H3MShop
//
//  Created by Van Huy on 18/10/2022.
//

import SwiftUI

struct NotificationView: View {
    
    var customSize = CustomSize()
    
    var body: some View {
        VStack(alignment: .leading){
            header
            Text("Notification")
                .modifier(Fonts(fontName: .outfit_regular,
                                colorName: .black,
                                size: 28))
                .padding(.leading)
            
            notificationRow
            
            Text("Order Update")
                .modifier(Fonts(fontName: .outfit_regular,
                                colorName: .black,
                                size: 28))
                .padding(.leading)
            
            ScrollView{
                OrderUpdateRow(image: "shoes1",
                               title: "Giao hàng thành công",
                               descrip: "Kiện hàng SPXVN02777850 của đơn hàng 2210 đã giao thành công đến bạn")
                .padding(.bottom,-14)
                OrderUpdateRow(image: "shoes2",
                               title: "Giao hàng thành công",
                               descrip: "Kiện hàng ABCD2777850 của đơn hàng 211310 đã giao thành công đến bạn")
                .padding(.bottom,-14)
                OrderUpdateRow(image: "shoes1",
                               title: "Đơn hàng đang được vận chuyển",
                               descrip: "Kiện hàng KSCN02777850 của đơn hàng 22127270 đã giao thành công đến bạn")
            }
            
            Spacer()
            

            
            
        }
        .background(Color(ColorsName.white.rawValue).opacity(0.05))
    }
}

struct NotificationView_Previews: PreviewProvider {
    static var previews: some View {
        NotificationView()
    }
}
extension NotificationView {
    var header: some View {
        HStack{
            Button {
                //MARK: GO TO MAIN
            } label: {
                Image("Main.Menu")
                    .resizable()
                    .frame(width: customSize.heightButtonList,
                           height: customSize.heightButtonList)
            }
            
            Spacer()
            Text("H3M")
                .modifier(Fonts(fontName: .outfit_regular,
                                colorName: .black,
                                size: customSize.heightButtonList))
            Spacer()
            Button {
                //MARK: GO TO WISHLIST
            } label: {
                Image(systemName: "bag")
                    .font(.title3)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.purple)
                    .clipShape(Circle())
                    .overlay(
                    Text("1")
                        .font(.caption)
                        .fontWeight(.bold)
                        .foregroundColor(Color.white)
                        .padding(10)
                        .background(Color.red)
                        .clipShape(Circle())
                        .offset(x:15,y:-20)
                    )
            }
            
            
        }
        .padding(.leading)
        .padding(.trailing)
    }
    var notificationRow: some View {
        VStack{
            NotificationRow(image: "Notification.Sale",
                            name: "Promotion",
                            descrip: "Promotion code is here now")
            .padding(.bottom,-14)
            NotificationRow(image: "Notification.Update",
                            name: "Update Cart",
                            descrip: "My cart is ready to update")
            .padding(.bottom,-14)

            NotificationRow(image: "Notification.Present",
                            name: "Present",
                            descrip: "Many Presents give you")
            .padding(.bottom,-14)
            NotificationRow(image: "Notification.Loyalty",
                            name: "Loyalty Customer",
                            descrip: "Welcome to Loyalty Customer")
        }
    }
}
