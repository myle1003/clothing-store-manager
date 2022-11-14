//
//  ButtonView.swift
//  H3MShop
//
//  Created by Van Huy on 12/10/2022.
//

import SwiftUI

struct ButtonView: View {
    var customSize = CustomSize()
    var text: String
    var body: some View {
        Text(text)
            .frame(width: 328,height: 48)
            .modifier(Fonts(fontName: .outfit_bold, colorName: .white, size: customSize.textButton))
            .background(                                LinearGradient(colors: [Color(ColorsName.purple.rawValue),Color(ColorsName.blue.rawValue)], startPoint: .top, endPoint: .bottom))
            .cornerRadius(8)
    }
}

struct ButtonView_Previews: PreviewProvider {
    static var previews: some View {
        ButtonView(text: "Let's Start")
    }
}
