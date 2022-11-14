//
//  CustomCorners.swift
//  H3MShop
//
//  Created by Van Huy on 18/10/2022.
//

import SwiftUI

struct CustomCorners: Shape {
    
    var corners: UIRectCorner
    var radius: CGFloat
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect,
                                byRoundingCorners: corners,
                                cornerRadii: CGSize(width: radius,
                                                    height: radius))
        return Path(path.cgPath)
    }
}

