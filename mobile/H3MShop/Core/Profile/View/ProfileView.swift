//
//  ProfileView.swift
//  H3MShop
//
//  Created by Van Huy on 18/10/2022.
//

import SwiftUI
import Kingfisher

struct ProfileView: View {
    
    @StateObject var authViewModel = Authentincation()
    @State var isLogout = false
    
    var customSize = CustomSize()
    
    var body: some View {
        VStack{
            
                VStack{
                    header
                    
                    profile
                    
                    
                    profileRow 
                    Button {
                        //MARK:  LOGOUT
                        authViewModel.token = ""
                        self.isLogout = true
                    } label: {
                        EditRow(image: "Profile.Logout", name: "Log Out")

                        
                        
                    }
                    
                    NavigationLink(destination: LoginView(), isActive: self.$isLogout) {}
                    
                    Spacer()
                    
                }
            
        }
        .background(Color(ColorsName.white.rawValue).opacity(0.05))
        
        
        
        
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}

extension ProfileView{
    var header: some View {
        HStack{
            
            
            Spacer()
            Text("My Profile")
                .modifier(Fonts(fontName: .outfit_regular,
                                colorName: .black,
                                size: customSize.heightButtonList))
                .padding(.bottom)
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
                    KFImage(URL(string: authViewModel.currenUser!.urlImage ))
                        .resizable()
                        .frame(width:200,height: 200)
                        .cornerRadius(200)
                )
                .overlay(
                    Circle()
                        .stroke(AngularGradient(gradient: .init(colors: [Color.purple.opacity(0.3),Color.purple.opacity(0)]), center: .top))
                        .frame(width: 300,height: 300)
                )
                .padding(.bottom)
            
            Text(authViewModel.fullname)
                .modifier(Fonts(fontName: .outfit_bold,
                                colorName: .black,
                                size: 20))
                .padding(.bottom)
            HStack(spacing: 5, content: {
                Circle()
                    .frame(width: 12,height: 12)
                    .foregroundColor(Color(ColorsName.green.rawValue))
                Text("Activate Now")
                    .modifier(Fonts(fontName: .outfit_light,
                                    colorName: .black,
                                    size: 15))
            })
            .padding(.top,-8)
            .padding(.bottom)
        }
    }
    var profileRow: some View {
        VStack(alignment: .leading){
            
            
            NavigationLink(destination: EditProfileView()) {
                EditRow(image: "Profile.edit", name: "Edit Profile")
                    .padding(.bottom)
            }
            
            
            
            NavigationLink(destination: MyAddressView()) {
                EditRow(image: "Profile.location", name: "My Address")
                   
                    .padding(.bottom)
            }
            
            
            
            NavigationLink(destination: OrderHistoryView()) {
                EditRow(image: "Profile.history", name: "Order History")
                    .padding(.bottom)
                
            }
            
            
            
            NavigationLink(destination: ChangePasswordView()) {
                EditRow(image: "Profile.ChangePassword", name: "Change Password")
                    .padding(.bottom)
                    
                    
        
                
            }
            
            
            
        }
        
    }
}
