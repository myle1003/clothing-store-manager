//
//  OrderHistoryRow.swift
//  H3MShop
//
//  Created by Lê Văn Huy on 07/11/2022.
//

import SwiftUI
import Kingfisher
struct OrderHistoryRow: View {
    var bill : Bill
    var body: some View {
        VStack{
            Divider()
                .padding(.leading,-16)
                .padding(.trailing,-16)

            NavigationLink(destination: BillDetail(bill: bill)) {
                VStack{
                    HStack(alignment: .top,spacing: 1){
                        KFImage(URL(string: bill.id_bill.product.first!.id_product.urlImage.first!))
                            .resizable()
                            .frame(width: 80,height:80)
                        VStack(alignment: .leading){
                            Text(bill.id_bill.product.first!.id_product.name)
                                .modifier(Fonts(fontName: .outfit_regular,
                                                colorName: .black,
                                                size: 18))
                            HStack{
                                Spacer()
                                Text("x\(bill.id_bill.product.first!.number)")
                                    .modifier(Fonts(fontName: .outfit_regular,
                                                    colorName: .black,
                                                    size: 16))
                            }
                            HStack{
                                Spacer()
                                Text("đ\(bill.id_bill.product.first!.price)")
                                    .modifier(Fonts(fontName: .outfit_regular,
                                                    colorName: .red,
                                                    size: 18))
                                    .padding(.top,2)
                                    
                            }

                        }
                        .padding(.leading,3)
                        Spacer()
                    }
                    Divider()
                        .padding(.leading,-16)
                        .padding(.trailing,-16)

                    HStack{
                        Text("\(bill.id_bill.product.count) items")
                            .modifier(Fonts(fontName: .outfit_regular,
                                            colorName: .black,
                                            size: 16))
                        Spacer()
                        Image("dollar")
                            .resizable()
                            .frame(width: 20,height:20)
                        Text("Order Total: đ\(bill.id_bill.totalPrice)")
                            .modifier(Fonts(fontName: .outfit_regular,
                                            colorName: .black,
                                            size: 18))

                    }
                    Divider()
                        .padding(.leading,-16)
                        .padding(.trailing,-16)
                }
            }
            
            

            
            NavigationLink(destination: TrackOrderView(history: bill.history)) {
                HStack{
                    Text(bill.history.last!.id_status.name)
                        .modifier(Fonts(fontName: .outfit_regular,
                                        colorName: .green,
                                        size: 16))
                    
                    Spacer()
                    Image(systemName: "chevron.right")
                }
                .padding(2)
            }
            
            Divider()
                .padding(.leading,-16)
                .padding(.trailing,-16)

//            HStack{
//                Text("Receive at 8 Th10 2022 16:30")
//                    .modifier(Fonts(fontName: .outfit_regular,
//                                    colorName: .black,
//                                    size: 16))
//                Spacer()
//
//                NavigationLink {
//                    TrackOrderView()
//                } label: {
//                    Text("Rate")
//                        .modifier(Fonts(fontName: .outfit_bold,
//                                        colorName: .white,
//                                        size: 18))
//                        .frame(width: 100,height:40)
//                        .background(Color.orange)
//                        .cornerRadius(5)
//                }
//
//
//            }
//            Divider()
//                .padding(.leading,-16)
//                .padding(.trailing,-16)

        }
        .padding()
        .padding(.top,-16)
        .padding(.bottom,-16)
        .background(Color(ColorsName.white.rawValue))
    }
}

//struct OrderHistoryRow_Previews: PreviewProvider {
//    static var previews: some View {
//        OrderHistoryRow(bill: Bill)
//    }
//}
