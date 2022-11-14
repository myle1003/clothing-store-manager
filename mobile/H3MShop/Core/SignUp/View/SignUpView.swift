//
//  SignUpView.swift
//  H3MShop
//
//  Created by Van Huy on 14/10/2022.
//

import SwiftUI

struct SignUpView: View {
    
    
    
    @ObservedObject var vm = SignUpViewModel()
    
    @State var toLoginView = false
    @State var animate = false
    @State var isNotification = false
    
    var customSize = CustomSize()
    
    var body: some View {
        ZStack{
            VStack{
                BackgroundView(title: "Sign Up Account",
                               descrip: "Welcome to H3M Shop")
                
                field
                
                Button {
                    //MARK: SIGN UP
                    if vm.isEmptyFields() {
                        vm.isEmptyField = true
                    }
                    else if vm.isRightAllFields() {
                        Task{
                            do {
                                isNotification = false
                                vm.isCheck = true
                                let object = try await vm.register()
                                vm.response = object
                            }
                            catch{
                                print("💨 error : \(error)")
                            }
                        }
                    }
                    else {
                        vm.isEmptyField = false
                        vm.isRightAllField = false
                    }
                } label: {
                    ButtonView(text: "Sign up")
                }
                .padding(.top,20)
                
                withAnimation(.easeInOut){
                    Text(vm.isEmptyField ? FailureSignUp.emptyField.rawValue
                         : FailureSignUp.none.rawValue)
                    .modifier(Fonts(fontName: .outfit_light,
                                    colorName: .red,
                                    size: 10))
                }
                
                withAnimation(.easeInOut){
                    Text(vm.isRightAllField ? FailureSignUp.none.rawValue : FailureSignUp.wrongField.rawValue)
                        .modifier(Fonts(fontName: .outfit_light,
                                        colorName: .red,
                                        size: 10))
                }
                
                
                Spacer()
                
                tologin
                
                
            }
            .onChange(of: vm.response, perform: { _ in
                isNotification = true
            })
            .onChange(of: vm.email, perform: { email in
                if vm.isValidEmails() {
                    vm.isValidEmail = true
                }
                else {
                    vm.isValidEmail = false
                }
                
                if email == "" {
                    vm.isFocusEmail = false
                }
                else {
                    vm.isFocusEmail = true
                }
            })
            .onChange(of: vm.name, perform: { name in
                if vm.isValidUsername() {
                    vm.isValidUserName = true
                }
                else {
                    vm.isValidUserName = false
                }
                
                if name == "" {
                    vm.isFocusUserName = false
                }
                else {
                    vm.isFocusUserName = true
                }
            })
            .onChange(of: vm.password, perform: { password in
                if vm.isValidPassWord() {
                    vm.isValidPassword = true
                }
                else {
                    vm.isValidPassword = false
                }
                
                if password == "" {
                    vm.isFocusPassword = false
                }
                else {
                    vm.isFocusPassword = true
                }
            })
            .onChange(of: vm.password2, perform: { password2 in
                if vm.checkPasswordConfirm() {
                    vm.isCofirmPassword = true
                }
                else {
                    vm.isCofirmPassword = false
                }
                
                if password2 == "" {
                    vm.isFocusCofirmPassword = false
                }
                else {
                    vm.isFocusCofirmPassword = true
                }

            })
            
            if vm.isCheck {
                withAnimation(.easeInOut){
                    alert
                }
                }
            }
        
        .navigationBarHidden(true)
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}

extension SignUpView {
    var field: some View {
        VStack{
            VStack(alignment: .leading){
                Text("Email")
                    .modifier(Fonts(fontName: .outfit_light,
                                    colorName: .black,
                                    size: customSize.textButton))
                    .padding(.leading)
                    .padding(.bottom,-8)
                
                ZStack{
                    TextFieldView(placeholder: "Email",
                                  isSecure: false, text: $vm.email)
                    withAnimation(.spring()){
                        Text(vm.isFocusEmail ? (vm.isValidEmail ?  SucessLogin.valids.rawValue :
                                                FailureSignUp.wrong.rawValue) : FailureSignUp.none.rawValue)
                        .modifier(Fonts(fontName: .outfit_light,
                                        colorName: vm.isValidEmail ? .green : .red,
                                        size: customSize.textLoginSize))
                        .offset(x:160,y:8)
                        .frame(height: 15)

                    }
                }
                
            }
            
            VStack(alignment: .leading){
                Text("Username")
                    .modifier(Fonts(fontName: .outfit_light,
                                    colorName: .black,
                                    size: customSize.textButton))
                    .padding(.leading)
                    .padding(.bottom,-8)
                
                ZStack{
                    TextFieldView(placeholder: "Username",
                                  isSecure: false, text: $vm.name)
                    withAnimation(.spring()){
                        Text(vm.isFocusUserName ? (vm.isValidUserName ?  SucessLogin.valids.rawValue :
                                                    FailureSignUp.wrong.rawValue) : FailureSignUp.none.rawValue)
                        .modifier(Fonts(fontName: .outfit_light,
                                        colorName: vm.isValidUserName ? .green : .red,
                                        size: customSize.textLoginSize))
                        .offset(x:160,y:8)
                        .frame(height: 15)
                    }
                    
                }
            }
            
            VStack(alignment: .leading){
                Text("Password")
                    .modifier(Fonts(fontName: .outfit_light,
                                    colorName: .black,
                                    size: customSize.textButton))
                    .padding(.leading)
                    .padding(.bottom,-8)
                
                
                ZStack{
                    TextFieldView(placeholder: "Password",
                                  isSecure: true, text: $vm.password)
                    withAnimation(.spring()){
                        Text(vm.isFocusPassword ? (vm.isValidPassword ?  SucessLogin.valids.rawValue :
                                                    FailureSignUp.wrong.rawValue) : FailureSignUp.none.rawValue)
                        .modifier(Fonts(fontName: .outfit_light,
                                        colorName: vm.isValidPassword ? .green : .red,
                                        size: customSize.textLoginSize))
                        .offset(x:160,y:8)
                        .frame(height: 15)
                    }
                }
            }
            
            VStack(alignment: .leading){
                Text("Confirm password")
                    .modifier(Fonts(fontName: .outfit_light,
                                    colorName: .black,
                                    size: customSize.textButton))
                    .padding(.leading)
                    .padding(.bottom,-8)
                
                ZStack{
                    
                    TextFieldView(placeholder: "Confirm password",
                                  isSecure: true, text: $vm.password2)
                    withAnimation(.spring()){
                        Text(vm.isFocusCofirmPassword ? (vm.isCofirmPassword ?  SucessLogin.valids.rawValue :
                                                        FailureSignUp.wrong.rawValue) : FailureSignUp.none.rawValue)
                        .modifier(Fonts(fontName: .outfit_light,
                                        colorName: vm.isCofirmPassword ? .green : .red,
                                        size: customSize.textLoginSize))
                        .offset(x:160,y:8)
                        .frame(height: 15)
                        
                    }
                }
            }
            
        }
    }
    
    var tologin: some View {
        HStack{
            Text("Haven't an account ?")
                .modifier(Fonts(fontName: .outfit_thin, colorName: .gray, size: customSize.textLoginSize))
            
            //MARK: TO LOGIN VIEW
            NavigationLink(destination: LoginView()) {
                Text("Login")
                    .modifier(Fonts(fontName: .outfit_bold, colorName: .black, size: customSize.textLoginSize))
            }
            
        }
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
    
    var wait: some View {
        VStack{
            Spacer()
            
            Circle().stroke(AngularGradient(gradient: .init(colors: [Color.purple,Color.purple.opacity(0)]), center: .center))
                .frame(width: 60,height: 60)
                .rotationEffect(.init(degrees: animate ? 360 : 0 ))
            
            Spacer()
        }
    }
    
    var notification : some View {
        VStack{
            Text("Notification")
                .modifier(Fonts(fontName: .outfit_regular, colorName: .purple, size: 26))
                .padding()
            
            Text(vm.response.message)
                .multilineTextAlignment(.center)
                .frame(height: 40)
                .lineLimit(2)
                .padding(.leading)
                .padding(.trailing)
                .modifier(Fonts(fontName: .outfit_regular, colorName: .purple, size: 15))
            
            
            
            NavigationLink(destination: LoginView(), isActive: $toLoginView) {}
            
            
            Button {
                if vm.response.status == true {
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
}

