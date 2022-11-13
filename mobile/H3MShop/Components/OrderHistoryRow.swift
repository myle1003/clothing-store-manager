//
//  OrderHistoryRow.swift
//  H3MShop
//
//  Created by Lê Văn Huy on 07/11/2022.
//

import SwiftUI

struct OrderHistoryRow: View {
    var body: some View {
        VStack{
            Divider()
                .padding(.leading,-16)
                .padding(.trailing,-16)

            HStack(alignment: .top,spacing: 1){
                Image("test")
                    .resizable()
                    .frame(width: 80,height:80)
                VStack(alignment: .leading){
                    Text("Serum Giảm Mụn Oriskin GenZ")
                        .modifier(Fonts(fontName: .outfit_regular,
                                        colorName: .black,
                                        size: 18))
                    HStack{
                        Spacer()
                        Text("x1")
                            .modifier(Fonts(fontName: .outfit_regular,
                                            colorName: .black,
                                            size: 16))
                    }
                    HStack{
                        Spacer()
                        Text("đ349.000")
                            .strikethrough()
                            .modifier(Fonts(fontName: .outfit_regular,
                                            colorName: .gray,
                                            size: 16))
                        Text("đ247.000")
                            .modifier(Fonts(fontName: .outfit_regular,
                                            colorName: .red,
                                            size: 18))
                            
                    }

                }
                .padding(.leading,3)
                Spacer()
            }
            Divider()
                .padding(.leading,-16)
                .padding(.trailing,-16)

            HStack{
                Text("1 items")
                    .modifier(Fonts(fontName: .outfit_regular,
                                    colorName: .black,
                                    size: 16))
                Spacer()
                Image("dollar")
                    .resizable()
                    .frame(width: 20,height:20)
                Text("Order Total: đ247.000")
                    .modifier(Fonts(fontName: .outfit_regular,
                                    colorName: .black,
                                    size: 18))

            }
            Divider()
                .padding(.leading,-16)
                .padding(.trailing,-16)
            HStack{
                Text("Giao hàng thành công")
                    .modifier(Fonts(fontName: .outfit_regular,
                                    colorName: .green,
                                    size: 16))
                
                Spacer()
                Image(systemName: "chevron.right")
            }
            .padding(2)
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

struct OrderHistoryRow_Previews: PreviewProvider {
    static var previews: some View {
        OrderHistoryRow()
    }
}
