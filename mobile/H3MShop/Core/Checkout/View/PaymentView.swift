//
//  PaymentView.swift
//  H3MShop
//
//  Created by Lê Văn Huy on 06/11/2022.
//

import SwiftUI

struct PaymentView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var authViewModel: Authentincation
    @Binding var name: String
    var customSize =  CustomSize()
    var body: some View {
        VStack{
           header
            HStack(alignment: .top){
                Image("debit-card")
                    .resizable()
                    .frame(width: 30,height:30)
                VStack(alignment: .leading){
                    Text("Transfer Banking")
                        .modifier(Fonts(fontName: .outfit_regular,
                                        colorName: .black,
                                        size: 20))
                    ForEach(authViewModel.info.card){ card in
                        
                        Button {
                            self.name = card.bank + "[\(card.number)]"
                            presentationMode.wrappedValue.dismiss()
                        } label: {
                            VStack(alignment: .leading){
                                HStack{
                                    Text(card.bank)
                                        .modifier(Fonts(fontName: .outfit_regular,
                                                        colorName: .black,
                                                        size: 18))
                                    Spacer()
                                    Text(card.number)
                                        .modifier(Fonts(fontName: .outfit_regular,
                                                        colorName: .black,
                                                        size: 18))
                                }
                                Text(card.name)
                                    .modifier(Fonts(fontName: .outfit_regular,
                                                    colorName: .gray,
                                                    size: 16))
                            }
                            .padding(2)
                        }

                        
                    }
                    
                
                }
                Spacer()
            }
            .padding()
            
            Button {
                self.name = "Cash on Delivery"
                presentationMode.wrappedValue.dismiss()
            } label: {
                HStack{
                    Image("payment-method")
                        .resizable()
                        .frame(width: 30,height:30)
                    VStack(alignment: .leading){
                        Text("Cash on Delivery")
                            .modifier(Fonts(fontName: .outfit_regular,
                                            colorName: .black,
                                            size: 20))
                    }
                    Spacer()
                }
                .padding()
            }

            
            Spacer()
            
        }
        .navigationBarHidden(true)
        .background(Color(ColorsName.white.rawValue).opacity(0.05))
        
    }
}

struct PaymentView_Previews: PreviewProvider {
    static var previews: some View {
        PaymentView(name: .constant(""))
            .environmentObject(Authentincation())
    }
}

extension PaymentView {
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
            
            Text("Payment Method")
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
