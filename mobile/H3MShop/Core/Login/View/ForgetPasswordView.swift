//
//  ForgetPasswordView.swift
//  H3MShop
//
//  Created by Lê Văn Huy on 28/10/2022.
//

import SwiftUI

struct ForgetPasswordView: View {
    
    @State var animate = false
    
    @State var isSuccess = false
    @State var emailForget: String = ""
    @State var isWait = false
    @Environment(\.presentationMode) var presentationMode
    
    var customSize =  CustomSize()
    
    var body: some View {
        ZStack{
            VStack(){
                
                HStack{
                    Button {
                        //MARK: GO TO MAIN
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        Image("Main.back")
                            .resizable()
                            .frame(width: customSize.mainButtonDetail,
                                   height: customSize.mainButtonDetail)
                    }
                    Spacer()
                }
                .padding(.leading)
                
                HStack{
                    Text("Please press your email")
                        .modifier(Fonts(fontName: .outfit_light,
                                           colorName: .purple,
                                           size: 30))
                        .padding(.bottom)
                        .padding(.horizontal,20)
                    Spacer()
                }
                TextFieldView(placeholder: "Email", isSecure: false, text: $emailForget)
                
                withAnimation(.easeInOut){
                    Text("Email isn't exist")
                        .modifier(Fonts(fontName: .outfit_light,
                                        colorName: .red,
                                        size: 15))
                        .padding(.top)
                }
                
                Button {
                    //
                    isWait = true
                } label: {
                    ButtonView(text: "Send verify to your email")
                        .padding()
                }

                Spacer()
            }
            
            if isWait{
                wait
            }
        }
        .navigationBarHidden(true)
        
    }
}

struct ForgetPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ForgetPasswordView()
    }
}
extension ForgetPasswordView {
    var wait: some View {
        VStack{
            Text("Please wait")
                .modifier(Fonts(fontName: .outfit_regular, colorName: .purple, size: 26))
                .padding()
            
            Circle().stroke(AngularGradient(gradient: .init(colors: [Color.purple,Color.purple.opacity(0)]), center: .center))
                .frame(width: 80,height: 80)
                .rotationEffect(.init(degrees: animate ? 360 : 0 ))
            
            Spacer()
        }
        .onAppear{
            withAnimation(Animation.linear(duration: 1.5).repeatForever(autoreverses: false)){
                animate.toggle()
            }
        }
        .frame(width: 250,height: 180)
        .background(Color(ColorsName.alert.rawValue))
        .cornerRadius(20)
        .shadow(radius: 5)
    }

}
