//
//  AddressRowView.swift
//  H3MShop
//
//  Created by Lê Văn Huy on 07/11/2022.
//

import SwiftUI

struct AddressRowView: View {
    var inforAddress: InfoAddress
    var body: some View {
        VStack(alignment: .leading,spacing: 10){
            Divider()
                .padding(.leading,-24)
                .padding(.trailing,-24)
            HStack{
                Text(inforAddress.name)
                Text("|")
                Text(inforAddress.phone)
                
            }
            .modifier(Fonts(fontName: .outfit_regular,
                            colorName: .black,
                            size: 18))
            VStack(alignment: .leading){
                Text(inforAddress.address.street)
                Text("\(inforAddress.address.id_commune.name), \(inforAddress.address.id_district.name),\(inforAddress.address.id_province.name)")
                
            }
            .modifier(Fonts(fontName: .outfit_regular,
                            colorName: .gray,
                            size: 16))
            
            if inforAddress.role{
                Text("Default")
                    .modifier(Fonts(fontName: .outfit_regular,
                                    colorName: .red,
                                    size: 12))
                    .frame(width: 50,height: 20)
                    .overlay(
                    Rectangle()
                        .stroke(lineWidth: 0.5)
                        .foregroundColor(Color.red)
                    )
            }
            Divider()
                .padding(.leading,-24)
                .padding(.trailing,-24)
        }
        .padding(.leading)
        .padding(.trailing)
    }
}

struct AddressRowView_Previews: PreviewProvider {
    static var previews: some View {
        AddressRowView(inforAddress: InfoAddress())
    }
}
