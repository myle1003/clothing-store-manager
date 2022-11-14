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
    @State var toLoginView = false
    @State var isNotification = false
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var vm = LoginViewModel()
    
    var customSize =  CustomSize()
    
    var body: some View {
        ZStack{
            if vm.isCheck {
                withAnimation(.easeInOut){
                    alert
                }
                }
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
                    Text(vm.forgotResponse.status ? "" : vm.forgotResponse.message)
                        .modifier(Fonts(fontName: .outfit_light,
                                        colorName: .red,
                                        size: 10))
                }
                
                Button {
                    Task{
                        do {
                            isNotification = false
                            vm.isCheck = true
                            let object = try await vm.forgotPassword(with: emailForget)
                            vm.forgotResponse = object
                            print(vm.forgotResponse.message)
                        }
                        catch{
                            print("💨 error : \(error)")
                        }
                    }
                } label: {
                    ButtonView(text: "Send verify to your email")
                        .padding()
                }

                Spacer()
            }
            
            

            
        }
        .onChange(of: vm.forgotResponse, perform: { _ in
            if vm.forgotResponse.status == true {
                isNotification = true
            }
            else if vm.response.status == false {
                vm.isCheck = false
            }
        })
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
    var notification : some View {
        VStack{
            Text("Notification")
                .modifier(Fonts(fontName: .outfit_regular, colorName: .purple, size: 26))
                .padding()
            
            Text(vm.forgotResponse.message)
                .multilineTextAlignment(.center)
                .frame(height: 40)
                .lineLimit(2)
                .padding(.leading)
                .padding(.trailing)
                .modifier(Fonts(fontName: .outfit_regular, colorName: .purple, size: 15))
            
            
            
            NavigationLink(destination: LoginView(), isActive: $toLoginView) {}
            
            
            Button {
                if vm.forgotResponse.status == true {
                    toLoginView.toggle()
                }
                else  {
                    vm.isCheck = false
                }
            } label: {
                Text("OK")
                    .frame(width: 80,height: 35)
                    .background(LinearGradient(colors: [Color(ColorsName.purple.rawValue),Color(ColorsName.blue.rawValue)], startPoint: .top, endPoint: .bottom))
                    .modifier(Fonts(fontName: .outfit_bold, colorName: .white, size: 15))
                    .cornerRadius(5)
                    .padding()
            }
        }
        .frame(width: 250,height: 180)
        .background(Color(ColorsName.alert.rawValue))
        .cornerRadius(20)
        .shadow(radius: 5)
    }
    
    var alert: some View {
        VStack(alignment: .center){
            
            if isNotification {
                withAnimation(.easeInOut){
                    notification
                }
            }
            else {
                withAnimation(.easeInOut){
                    wait
                }
            }
            
        }
        .onAppear{
            withAnimation(Animation.linear(duration: 1.5).repeatForever(autoreverses: false)){
                animate.toggle()
            }
        }

    }

}
