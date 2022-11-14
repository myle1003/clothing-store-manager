//
//  StatusRow.swift
//  H3MShop
//
//  Created by Lê Văn Huy on 01/11/2022.
//

import SwiftUI

struct StatusRow: View {
    var status: String
    var time: String
    var body: some View {
        VStack{
            HStack{
                VStack(alignment: .leading){
                    Text(status)
                        .modifier(Fonts(fontName: .outfit_regular, colorName: .black, size: 20))
                    Text(time)
                        .modifier(Fonts(fontName: .outfit_light, colorName: .gray, size: 16))
                }
                Spacer()
                Image(systemName: "checkmark.diamond.fill")
                    .modifier(Fonts(fontName: .outfit_light, colorName: .green, size: 20))
            }
            .padding()
        }
    }
}

struct StatusRow_Previews: PreviewProvider {
    static var previews: some View {
        StatusRow(status: "Order is Accept", time: "13 Oct 12:50 PM")
    }
}
