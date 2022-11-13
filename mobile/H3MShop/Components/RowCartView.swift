//
//  RowCartView.swift
//  H3MShop
//
//  Created by Van Huy on 17/10/2022.
//

import SwiftUI
import Kingfisher

struct RowCartView: View {
    
    var id_product: String
    var urlImage: String
    var name: String
    var color: String
    var size: String
    var discount: Int
    @StateObject var vm = CartViewModel()
    @State var  price: Int = 0
    @State var quantity: Int = 1
    var customSize =  CustomSize()
    var body: some View {
        VStack(alignment: .leading){
            HStack{
                
                VStack{
                    KFImage(URL(string: urlImage))
                        .resizable()
                        .frame(width:90,
                               height:90)
                        .cornerRadius(5)
                }
                .frame(width:customSize.rowImageCartSize,
                       height:customSize.rowImageCartSize)
                .background(Color(ColorsName.rowImage.rawValue).opacity(0.4))
                .cornerRadius(20)
                
                VStack(alignment: .leading){
                    Text(name)
                        .modifier(Fonts(fontName: .outfit_bold,
                                        colorName: .black,
                                        size: customSize.textButton))
                    Text("\(price * quantity) đ")
                        .modifier(Fonts(fontName: .outfit_light,
                                        colorName: .gray,
                                        size: customSize.textButton ))
                    HStack{
                        Text("Color: \(color)")
                        Text("Size: \(size)")
                    }
                    .modifier(Fonts(fontName: .outfit_regular,
                                    colorName: .black,
                                    size: 14 ))
                    
                    
                    Spacer()
                    
                    HStack{
                        Button {
                            //MARK: DISTRUBRB
                            Task{
                                do{
                                    
                                    if self.quantity > 1 {
                                        self.quantity -= 1
                                        try await vm.editCart(id_product: id_product, number: quantity)
                                    }
                                    else{
                                        try await
                                        vm.deleteRowCart(id_product: id_product)
                                    }
                                }
                                catch{
                                    
                                }
                            }
                        } label: {
                            Image("Cart.distrurb")
                                .resizable()
                                .frame(width:customSize.buttonCartSize,
                                       height:customSize.buttonCartSize)
                        }

                        Text("\(quantity)")
                            .frame(width: 30)
                            .modifier(Fonts(fontName: .outfit_regular,
                                            colorName: .black,
                                            size: customSize.textButton))
                            .padding(8)
                        Button {
                            Task{
                                do{
                                    self.quantity += 1
                                    try await vm.editCart(id_product: id_product, number: quantity)
                                }
                                catch{
                                    
                                }
                            }
                        } label: {
                            Image("Cart.plus")
                                .resizable()
                                .frame(width:customSize.buttonCartSize,
                                       height:customSize.buttonCartSize)
                        }

                        Spacer()
                        Button {
                            //MARK: TRASH
                            //MARK: HAVE PROBLEM
                            Task{
                                do{
                                    try await vm.deleteRowCart(id_product: id_product)
                                }
                                catch{
                                    
                                }
                            }
                        } label: {
                            Image("Cart.trash")
                                .resizable()
                                .frame(width:customSize.buttonCartSize,
                                       height:customSize.buttonCartSize)
                                .padding(.leading,3)
                        }

                    }
                }
                .padding(.leading)
                
                Spacer()
            }
            .padding()
            .overlay(
                    Image("Main.discount")
                        .resizable()
                        .frame(width: 40,height:50)
                        .overlay(
                        Text("\(discount)%")
                            .modifier(Fonts(fontName: .outfit_bold,
                                            colorName: .red,
                                            size: 10))
                        )
                        .offset(x:-82,y:-32)
            )
            Spacer()
        }
        .onChange(of: vm.carts, perform: { newValue in
            vm.getCart()
        })
        .frame(height:customSize.heightRowCart)
        .background(Color(ColorsName.white.rawValue))
        .cornerRadius(20)
        .padding(.leading)
        .padding(.trailing)
        .overlay(Rectangle()
            .stroke()
            .foregroundColor(Color.gray.opacity(0.6)))
    }
}

struct RowCartView_Previews: PreviewProvider {
    static var previews: some View {
        RowCartView(id_product: "", urlImage: "http://res.cloudinary.com/dw4h0fvg5/image/upload/v1666504859/H3M_Store/1666504872764.jpg",
                    name: "Ao khoac hoddie",
                    color: "Red",
                    size: "M",
                    discount: 15, price: 3)
    }
}
