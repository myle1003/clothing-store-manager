//
//  MyAddressView.swift
//  H3MShop
//
//  Created by Lê Văn Huy on 07/11/2022.
//

import SwiftUI

struct MyAddressView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    var customSize =  CustomSize()
    
    var body: some View {
        VStack(alignment: .leading){
            header
            
            Text("Address")
                .modifier(Fonts(fontName: .outfit_regular,
                                colorName: .black,
                                size: 20))
            
            Spacer()
        }
        .background(Color(ColorsName.white.rawValue).opacity(0.05))
    }
}

struct MyAddressView_Previews: PreviewProvider {
    static var previews: some View {
        MyAddressView()
    }
}

extension MyAddressView {
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
            
            Text("My Address")
                .modifier(Fonts(fontName: .outfit_regular,
                                colorName: .black,
                                size: customSize.heightButtonList))
                .offset(x:-8)
            Spacer()
            
            
        }
        .padding(.leading)
        .padding(.trailing)
        
    }
}

