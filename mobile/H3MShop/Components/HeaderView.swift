//
//  HeaderView.swift
//  H3MShop
//
//  Created by Van Huy on 14/10/2022.
//

import SwiftUI

struct HeaderView: View {
    var title: String = ""
    var descrip: String = ""
    var customSize = CustomSize()
    var body: some View {
        VStack(alignment: .leading){
            HStack{
                Text(title)
                    .bold()
                Image(systemName: title == "" ? "" : "person")
                Spacer()
            }
            .modifier(Fonts(fontName: .outfit_thin,
                            colorName: .black,
                            size: customSize.titleLoginSize))
            .padding(.bottom,2)
            Text(descrip)
                .modifier(Fonts(fontName: .outfit_regular, colorName: .black, size: customSize.textLoginSize))
        }
        .padding()
        .overlay(
            ZStack(alignment: .topLeading){
                Circle()
                    .frame(width: customSize.widthbCircle,
                           height: customSize.heightbCircle)
                    .offset(x:customSize.xoffsetbCircle,
                            y:customSize.yoffsetbCircle)
                    .foregroundColor(Color(ColorsName.purple.rawValue))
                    .opacity(0.4)
                Circle()
                    .frame(width: customSize.widthsCircle,
                           height: customSize.heightsCircle)
                    .offset(x:customSize.xoffsetsCircle,
                            y: customSize.yoffsetsCircle)
                    .foregroundColor(Color(ColorsName.purple.rawValue))
                    .opacity(0.4)
            }
        )
    }
}

struct HeaderView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderView()
    }
}
