//
//  TextFieldView.swift
//  H3MShop
//
//  Created by Van Huy on 14/10/2022.
//

import SwiftUI

struct TextFieldView: View {
    var placeholder: String
    var customSize = CustomSize()
    var isSecure: Bool
    @Binding var text: String
    var body: some View {
        VStack{
            if isSecure == true {
                secureField
            }
            else {
                textField
            }
        }
    }
}

struct TextFieldView_Previews: PreviewProvider {
    static var previews: some View {
        TextFieldView(placeholder: "", isSecure: false, text: .constant(""))
    }
}

extension TextFieldView {
    var textField: some View {
        TextField(placeholder,text: $text)
                .padding(.horizontal,20)
                .frame(height: 60)
                .overlay (
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(lineWidth: 0.5)
                )
                .modifier(Fonts(fontName: .outfit_thin,
                                 colorName: .black,
                                 size: customSize.textField ))
                .padding(.top)
                .padding(.leading)
                .padding(.trailing)
    }
    
    var secureField: some View {
        SecureField(placeholder,text: $text)
                .padding(.horizontal,20)
                .frame(height: 60)
                .overlay (
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(lineWidth: 0.5)
                )
                .modifier(Fonts(fontName: .outfit_thin,
                                 colorName: .black,
                                 size: customSize.textField ))
                .padding(.top)
                .padding(.leading)
                .padding(.trailing)
    }
}
