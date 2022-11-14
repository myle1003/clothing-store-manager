//
//  PaymentView.swift
//  H3MShop
//
//  Created by Lê Văn Huy on 06/11/2022.
//

import SwiftUI

struct PaymentView: View {
    @Environment(\.presentationMode) var presentationMode
    @StateObject var vm = CheckOutViewModel()
    var customSize =  CustomSize()
    @Binding var paymentMethod: PaymentMethod
    var body: some View {
        VStack(alignment: .leading){
           header
            
            
            VStack(alignment: .leading){
                ForEach(vm.paymentMethod){ payment in
                    
                    
                    Button {
                        self.paymentMethod = payment
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        Text(payment.name)
                            .modifier(Fonts(fontName: .outfit_regular,
                                            colorName: .blue,
                                            size: 22))
                            .padding(.bottom,2)
                            .padding(.top,2)
                    }
                    
                    
                    ForEach(payment.card!){ card in
                        
                        HStack(){
                            Text(card.name)
                                .modifier(Fonts(fontName: .outfit_regular,
                                                colorName: .black,
                                                size: 20))
                            Spacer()
                            HStack{
                                Text(card.bank)
                                    .modifier(Fonts(fontName: .outfit_regular,
                                                    colorName: .black,
                                                    size: 18))
                                Text("[\(card.number)]")
                                    .modifier(Fonts(fontName: .outfit_regular,
                                                    colorName: .black,
                                                    size: 16))
                            }
                        }
                        
                        
                    }

                    
                }
            }
            .padding(.leading)
            .padding(.trailing)
            

            
            Spacer()
            
        }
        .navigationBarHidden(true)
        .background(Color(ColorsName.white.rawValue).opacity(0.05))
        
    }
}

struct PaymentView_Previews: PreviewProvider {
    static var previews: some View {
        PaymentView(paymentMethod: .constant(PaymentMethod()))
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
