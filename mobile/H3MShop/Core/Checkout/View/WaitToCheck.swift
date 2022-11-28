//
//  WaitToCheck.swift
//  H3MShop
//
//  Created by Lê Văn Huy on 06/11/2022.
//

import SwiftUI

struct WaitToCheck: View {
    var customSize =  CustomSize()
    var body: some View {
        VStack{
            header
            
            Image("Profile.TrackOrder")
                .resizable()
                .frame(width: 400,height: 400)
            NavigationLink {
                MainTabView()
            } label: {
                Text("Come back to Home")
                    .underline()
                    .modifier(Fonts(fontName: .outfit_regular,
                                    colorName: .green,
                                    size: 15))
            }
        }
        .navigationBarHidden(true)
        .background(Color(ColorsName.white.rawValue).opacity(0.05))
    }
}

struct WaitToCheck_Previews: PreviewProvider {
    static var previews: some View {
        WaitToCheck()
    }
}
extension WaitToCheck{
    var header: some View {
        HStack{
            
            Spacer()
            
            Text("Your placeorder is accepted!!!")
                .modifier(Fonts(fontName: .outfit_regular,
                                colorName: .green,
                                size: 25))
            Spacer()
            
            
        }
        .padding(.leading)
        .padding(.trailing)
    }
}
