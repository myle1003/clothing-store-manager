//
//  CustomFont.swift
//  H3MShop
//
//  Created by Van Huy on 12/10/2022.
//

import Foundation
import SwiftUI

enum FontsName: String {
    case outfit_thin = "Outfit-Thin"
    case outfit_light = "Outfit-Light"
    case outfit_bold = "Outfit-Bold"
    case outfit_semibold = "Outfit-SemiBold"
    case outfit_regular = "Outfit-Regular"
    case outfit_black = "Outfit-Black"
    case outfit_extraBold = "Outfit-ExtraBold"
}
enum ColorsName: String {
    case blue = "Splash.startLinear"
    case purple = "Splash.endLinear"
    case black = "Main.black"
    case red = "Main.red"
    case gray = "Main.gray"
    case nameProduct = "Main.nameProduct"
    case tabbar = "Main.tabbar"
    case star = "Main.star"
    case productCategory = "Main.productCategory"
    case white = "Main.white"
    case listCategory = "Main.listCategory"
    case rowImage = "Cart.RowImage"
    case green = "Main.green"
    case alert = "Main.Alert"
}
struct Fonts: ViewModifier{
    var fontName: FontsName
    var colorName: ColorsName
    var size: CGFloat
    func body(content: Content) -> some View {
        content
            .font(.custom(fontName.rawValue,
                          size: size))
            .foregroundColor(Color(colorName.rawValue))
    }
}
