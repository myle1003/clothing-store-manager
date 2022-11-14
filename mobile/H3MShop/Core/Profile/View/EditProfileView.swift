//
//  EditProfileView.swift
//  H3MShop
//
//  Created by Lê Văn Huy on 28/10/2022.
//

import SwiftUI
import Kingfisher
struct EditProfileView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var authViewModel : Authentincation
    
    
    
    @State var animate = false
    @State var isWait = false
    
    let genderOptions: [String] = ["Male","Female"]
    
    var customSize = CustomSize()

    var body: some View {
        
        ZStack {
            VStack{
                
                header
                
                profile
                
                editRow
                
                
                Spacer()
                
                Button {
                    //MARK: PROCESS TO CONFIRM
                    Task{
                        do {
                            isWait.toggle()
                            try await authViewModel.editProfile()
                            presentationMode.wrappedValue.dismiss()
                        }
                        catch{
                            
                        }
                    }
                } label: {
                    HStack{
                        Spacer()
                        ButtonView(text: "Save Change")
                            .cornerRadius(20)
                        Spacer()
                    }
                    .offset(y:-24)
                }
                
            }
            .navigationBarHidden(true)
            .background(Color(ColorsName.white.rawValue).opacity(0.05))
            if isWait {
                wait
            }
        }
    }
}

struct EditProfileView_Previews: PreviewProvider {
    static var previews: some View {
        EditProfileView()
            .environmentObject(Authentincation())
    }
}
extension EditProfileView {
    var header: some View {
        HStack{
            
            
            Button {
                //MARK: GO TO PROFILE
                presentationMode.wrappedValue.dismiss()
            } label: {
                Image("Main.back")
                    .resizable()
                    .frame(width: customSize.mainButtonDetail,
                           height: customSize.mainButtonDetail)
            }
            Spacer()
            
            Text("Edit Profile")
                .modifier(Fonts(fontName: .outfit_regular,
                                colorName: .black,
                                size: customSize.heightButtonList))
                .offset(x:-28)
            Spacer()
            
            
        }
        .padding(.leading)
        .padding(.trailing)
    }
    
    var profile: some View {
        VStack{
            Circle()
                .stroke(AngularGradient(gradient: .init(colors: [Color.purple.opacity(0.5),Color.purple.opacity(0)]), center: .top))
                .frame(width: 250,height: 250)
                .overlay(
                    KFImage(URL(string: authViewModel.currenUser!.urlImage))
                        .resizable()
                        .frame(width:200,height: 200)
                        .cornerRadius(200)
                )
                .overlay(
                    Circle()
                        .stroke(AngularGradient(gradient: .init(colors: [Color.purple.opacity(0.3),Color.purple.opacity(0)]), center: .top))
                        .frame(width: 300,height: 300)
                )
                .padding(.top)
           
            Text(authViewModel.currenUser!.fullname)
                .modifier(Fonts(fontName: .outfit_bold,
                                colorName: .black,
                                size: 20))
                .padding(.top,24)
        }
    }
    var editRow: some View {
        VStack(alignment: .leading){
            
            VStack(alignment: .leading){
                
                
                Text("Full Name")
                    .modifier(Fonts(fontName: .outfit_regular,
                                    colorName: .black,
                                    size: 20))
                    .padding(.bottom,2)
                TextField("",text: $authViewModel.fullname)
                    .modifier(Fonts(fontName: .outfit_regular,
                                    colorName: .black,
                                    size: 20))
                Divider()
                    .padding(.top,-10)
                    .padding(.bottom,2)
                
                
                Text("Gender")
                    .modifier(Fonts(fontName: .outfit_regular,
                                    colorName: .black,
                                    size: 20))
                    .padding(.bottom)
                
                Menu {
                    ForEach(genderOptions,id: \.self){
                        gender in
                        Button {
                            if gender == "Male" {
                                authViewModel.gender = true
                            }
                            else {
                                authViewModel.gender = false
                            }
                        } label: {
                            Text(gender)
                                .modifier(Fonts(fontName: .outfit_regular,
                                                colorName: .black,
                                                size: 20))
                                
                        }

                    }
                    
                    
                } label: {
                    withAnimation(.spring()){
                        Text(authViewModel.gender ? "Male" : "Female")
                            .modifier(Fonts(fontName: .outfit_regular,
                                            colorName: .black,
                                            size: 20))

                    }
                }
                

                
                
                Divider()
                    .padding(.top,-10)
                    .padding(.bottom,2)
                
                
                Text("Phone Number")
                    .modifier(Fonts(fontName: .outfit_regular,
                                    colorName: .black,
                                    size: 20))
                    .padding(.bottom,2)
                TextField("",text: $authViewModel.phone)
                    .modifier(Fonts(fontName: .outfit_regular,
                                    colorName: .black,
                                    size: 20))
                Divider()
                    .padding(.top,-10)
                    .padding(.bottom,2)
                
                
                
            }
            .padding(.leading)
            
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
