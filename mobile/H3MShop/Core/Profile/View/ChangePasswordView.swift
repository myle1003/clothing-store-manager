//
//  ChangePasswordView.swift
//  H3MShop
//
//  Created by Lê Văn Huy on 06/11/2022.
//

import SwiftUI

struct ChangePasswordView: View {
    
    @StateObject var vm = Authentincation()
    
    @State var animate = false
    
    @State var isSuccess = false
    @State var oldPassword: String = ""
    @State var newPassword: String = ""
    @State var comfirmPassword: String = ""
    @State var isWait = false
    @State var isCheck = false
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
                    Text("Change Password")
                        .modifier(Fonts(fontName: .outfit_light,
                                           colorName: .purple,
                                           size: 30))
                        .padding(.bottom)
                        .padding(.horizontal,20)
                    Spacer()
                }

                
                field
                
                if isCheck{
                    Text(vm.resetRespond.message)
                        .modifier(Fonts(fontName: .outfit_light,
                                        colorName: .red,
                                        size: 12))
                }
                
                
                Button {
                    
                    Task{
                        //
                        isWait = true
                        
                        let object = try await vm.resetPassword(current_password: oldPassword, newPassword: newPassword, confirmNewPassword: comfirmPassword)
                        
                        vm.resetRespond = object
                        
                        if object.status == false {
                            isCheck = true
                            isWait = false
                        }
                        else {
                            presentationMode.wrappedValue.dismiss()
                        }
                        
                        
                    }
                    
                } label: {
                    ButtonView(text: "Save Change")
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

struct ChangePasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ChangePasswordView()
    }
}
extension ChangePasswordView{
    var wait: some View {
        VStack{
            
            Spacer()
            
            Circle().stroke(AngularGradient(gradient: .init(colors: [Color.purple,Color.purple.opacity(0)]), center: .center))
                .frame(width: 60,height: 60)
                .rotationEffect(.init(degrees: animate ? 360 : 0 ))
            
            Spacer()
        }
        .onAppear{
            withAnimation(Animation.linear(duration: 1.5).repeatForever(autoreverses: false)){
                animate.toggle()
            }
        }
    }
    
    var field: some View {
        VStack{
            HStack{
                Text("Recent Password")
                    .modifier(Fonts(fontName: .outfit_light,
                                       colorName: .black,
                                       size: 20))
                Spacer()
            }
            .padding(.leading)
            TextFieldView(placeholder: "Current Password", isSecure: true, text: $oldPassword)
                .padding(.bottom,8)
            
            HStack{
                Text("New Password")
                    .modifier(Fonts(fontName: .outfit_light,
                                       colorName: .black,
                                       size: 20))
                Spacer()
            }
            .padding(.leading)
            TextFieldView(placeholder: "New Password", isSecure: true, text: $newPassword)
                .padding(.bottom,8)
            
            HStack{
                Text("Confirm Password")
                    .modifier(Fonts(fontName: .outfit_light,
                                       colorName: .black,
                                       size: 20))
                Spacer()
            }
            .padding(.leading)
            TextFieldView(placeholder: "Confirm Password", isSecure: true, text: $comfirmPassword)
                .padding(.bottom,8)
        }
    }
}
