//
//  NewProfileView.swift
//  H3MShop
//
//  Created by Lê Văn Huy on 29/10/2022.
//

import SwiftUI

struct NewProfileView: View {
    
    @EnvironmentObject var authViewModel: Authentincation
    
    let genderOptions: [String] = ["Male","Female"]
    var customSize = CustomSize()
    var body: some View {
        VStack{
            header
            profile
            editRow
                .offset(y:32)
            Spacer()
            
            Button {
                
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
    }
}

struct NewProfileView_Previews: PreviewProvider {
    static var previews: some View {
        NewProfileView()
            .environmentObject(Authentincation())
    }
}
extension NewProfileView {
    var header: some View {
        
        VStack(alignment: .leading){
            HStack{
                Text("Welcome to\n H3M")
                    .modifier(Fonts(fontName: .outfit_bold,
                                    colorName: .purple,
                                    size: 40))
                    .padding(.leading)
                Spacer()
            }
        
            HStack{
                Spacer()
                Text("Please fill your information")
                       .modifier(Fonts(fontName: .outfit_regular,
                                       colorName: .black,
                                       size: 24))
                       .padding(.top,-16)
                       .padding(.leading)
                       .padding(.bottom,24)
                Spacer()
            }
            
        }
    }
    
    var profile: some View {
        VStack{
            Circle()
                .stroke(AngularGradient(gradient: .init(colors: [Color.purple.opacity(0.5),Color.purple.opacity(0)]), center: .top))
                .frame(width: 200,height: 200)
                .overlay(
                    Image("test")
                        .resizable()
                        .frame(width:150,height: 150)
                        .cornerRadius(150)
                )
                .overlay(
                    Circle()
                        .stroke(AngularGradient(gradient: .init(colors: [Color.purple.opacity(0.3),Color.purple.opacity(0)]), center: .top))
                        .frame(width: 250,height: 250)
                )
                .padding(.top)
           
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
}
