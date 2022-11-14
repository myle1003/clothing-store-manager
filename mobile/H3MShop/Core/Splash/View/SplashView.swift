//
//  SplashView.swift
//  H3MShop
//
//  Created by Van Huy on 12/10/2022.
//

import SwiftUI

struct SplashView: View {
    var customSize = CustomSize()
    var body: some View {
        VStack{
            HeaderView()
            
            Image("Splash.main")
                .frame(width: 319,height: 365)
                .offset(x:0,y:50)
            
            description
            .padding(.top,80)
            
            
            //MARK: TO LOGIN VIEW
            NavigationLink(destination: LoginView(), label: {
                ButtonView(text: "Let's Start")
            })
            .padding(.top,25)

            
            Spacer()
        }
    }
}

struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView()
    }
}
extension SplashView {
    var description: some View {
        VStack{
            Text("Explore the app")
                .modifier(Fonts(fontName: .outfit_bold, colorName: .black, size: customSize.titleLoginSize))
                .padding(.bottom)
            Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi maecenas quis interdum enim enim molestie faucibus. Pretium non non massa eros, nunc, urna. Ac laoreet sagittis donec vel.Amet, duis justo, quam quisque egestas. Quam enim at dictum condimentum. Suspendisse.")
                .multilineTextAlignment(.center)
                .modifier(Fonts(fontName: .outfit_light, colorName: .black, size: customSize.textDescip))
                .padding(4)
        }
    }
}
