//
//  LoginView.swift
//  H3MShop
//
//  Created by Van Huy on 14/10/2022.
//

import SwiftUI

struct LoginView: View {
    
    @ObservedObject var vm = LoginViewModel()
    var customSize = CustomSize()
    @EnvironmentObject var authViewModel: Authentincation
    
    @State var animate = false
    
    @State var isSuccess = false
    @State var isWait = false
    
    var body: some View {
        ZStack{
            VStack(){
                BackgroundView(title: "Login Account",
                               descrip: "Welcome back to H3M Shop")
                
                field
                
                
                forgetPass
                
                Button {
                    //MARK: LOGIN
                    if vm.isEmptyFields(){
                        vm.isEmptyField = true
                    }
                    else if vm.isRightAllFields(){
                        Task{
                            do {
                                isWait = true
                                let object = try await vm.login()
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
                    ButtonView(text: "Login")
                }
                .padding(10)
                
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
                
                withAnimation(.easeInOut){
                    Text(vm.response.status ? "" : vm.response.message)
                        .modifier(Fonts(fontName: .outfit_light,
                                        colorName: .red,
                                        size: 10))
                }
                
                NavigationLink(destination: MainTabView(), isActive: $isSuccess) {}
                
                loginwith
                
                
                toregister
            }
            if isWait {
                wait
            }
        }
        .onChange(of: vm.response, perform: { response in
            if response.status == false {
                isWait = false
            }
            else {
                authViewModel.token = vm.response.token!
                authViewModel.getUser()
                authViewModel.getCart()
                isSuccess.toggle()
                
                
            }
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
        .navigationBarHidden(true)
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
            .environmentObject(Authentincation())
    }
}
extension LoginView {
    var field: some View {
        VStack{
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
            
            TextFieldView(placeholder: "Enter password",
                          isSecure: true, text: $vm.password)
        }
        
    }
    
    var forgetPass: some View {
        NavigationLink(destination: ForgetPasswordView()) {
            HStack{
                Spacer()
                Text("Forget Password ?")
            }
            .modifier(Fonts(fontName: .outfit_bold,
                            colorName: .black,
                            size: customSize.textLoginSize))
            .padding(.trailing)
        }
    }
    
    
    
    var loginwith: some View {
        VStack{
            Divider()
                .frame(width:customSize.widthButton)
                .overlay(
                    Text("Or sign up with")
                        .background(Color(ColorsName.white.rawValue))
                        .modifier(Fonts(fontName: .outfit_thin, colorName: .gray, size: customSize.textLoginSize))
                )
                .padding(20)
            
            HStack{
                Button {
                    //MARK: Login with Google
                } label: {
                    Image("Login.google")
                        .padding(20)
                }
                
                Button {
                    //MARK: Login with Facebook
                } label: {
                    Image("Login.facebook")
                        .padding(20)
                }
                
                Button {
                    //MARK: Login with Apple
                } label: {
                    Image("Login.apple")
                        .padding(20)
                }
            }
        }
    }
    
    var toregister: some View {
        HStack{
            Text("Not register yet ?")
                .modifier(Fonts(fontName: .outfit_thin, colorName: .gray, size: customSize.textLoginSize))
            
            //MARK: TO SIGNUP VIEW
            NavigationLink(destination: SignUpView()) {
                Text("Create Account")
                    .modifier(Fonts(fontName: .outfit_bold, colorName: .black, size: customSize.textLoginSize))
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
        .onAppear{
            withAnimation(Animation.linear(duration: 1.5).repeatForever(autoreverses: false)){
                animate.toggle()
            }
        }

    }
}
