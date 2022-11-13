//
//  ShoppingAddressView.swift
//  H3MShop
//
//  Created by Lê Văn Huy on 28/10/2022.
//

import SwiftUI

struct ShoppingAddressView: View {
    
    @EnvironmentObject var authViewModel: Authentincation
    @Environment(\.presentationMode) var presentationMode
    
    @State var animate = false
    @State var isWait = false
    
    var customSize = CustomSize()
    
    var body: some View {
        ZStack{
            VStack{
                header
                
                image
                
                
                
                VStack(){
                    Text("Your Addresss")
                        .modifier(Fonts(fontName: .outfit_regular,
                                        colorName: .black,
                                        size: 25))
                        .padding(.leading)
                        .padding(.top)
                        .padding(.bottom)
                    
                    editRow
                    
                    addressField
                }
                .offset(y:24)
                
                
                
                Spacer()
                
                Button {
                    //MARK: PROCESS TO CONFIRM
                    Task{
                        do{
                            isWait.toggle()
                            try await authViewModel.editAddress()
                            authViewModel.getUser()
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
                            .offset(y:-24)
                        Spacer()
                    }
                }
            }
            if isWait {
                wait
            }
            
        }
        .navigationBarHidden(true)
        .background(Color(ColorsName.white.rawValue).opacity(0.05))
    }
}

struct ShoppingAddressView_Previews: PreviewProvider {
    static var previews: some View {
        ShoppingAddressView()
            .environmentObject(Authentincation())
    }
}
extension ShoppingAddressView {
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
            
            Text("Shopping Address")
                .modifier(Fonts(fontName: .outfit_regular,
                                colorName: .black,
                                size: customSize.heightButtonList))
                .offset(x:-8)
            Spacer()
            
            
        }
        .padding(.leading)
        .padding(.trailing)
        
    }
    var image: some View {
        VStack{
            Circle()
                .stroke(AngularGradient(gradient: .init(colors: [Color.purple.opacity(0.5),Color.purple.opacity(0)]), center: .top))
                .frame(width: 200,height: 200)
                .overlay(
                    Image("Profile.address")
                        .resizable()
                        .frame(width:150,height: 150)
                        .offset(x:-8,y:-12)
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
            
            
            Text("Province")
                .modifier(Fonts(fontName: .outfit_regular,
                                colorName: .black,
                                size: 20))
                .padding(.bottom,2)
            
            Menu {
                ForEach(authViewModel.provinces){
                    province in
                    Button {
                        authViewModel.province = province
                        authViewModel.address.id_province = province._id
                        Task{
                            do {
                                isWait.toggle()
                                try await authViewModel.getDistrict()
                                authViewModel.district = authViewModel.districts.first!
                                authViewModel.address.id_district = authViewModel.district._id
                                try await authViewModel.getCommune()
                                isWait.toggle()
                            }
                            catch{
                                
                            }
                        }
                        
                    } label: {
                        Text(province.name)
                            .modifier(Fonts(fontName: .outfit_regular,
                                            colorName: .black,
                                            size: 20))
                        
                    }
                    
                }
                
                
                
            } label: {
                withAnimation(.spring()){
                    Text(authViewModel.province.name)
                        .modifier(Fonts(fontName: .outfit_regular,
                                        colorName: .black,
                                        size: 20))
                    
                }
            }
            
            
            Divider()
                .padding(.top,-10)
                .padding(.bottom,2)
            
            
            Text("District")
                .modifier(Fonts(fontName: .outfit_regular,
                                colorName: .black,
                                size: 20))
            
            Menu {
                ForEach(authViewModel.districts){
                    district in
                    Button {
                        authViewModel.district = district
                        authViewModel.address.id_district = district._id
                        Task{
                            do{
                                isWait.toggle()
                                try await authViewModel.getCommune()
                                isWait.toggle()
                            }
                            catch{
                                
                            }
                        }
                    } label: {
                        Text(district.name)
                            .modifier(Fonts(fontName: .outfit_regular,
                                            colorName: .black,
                                            size: 20))
                        
                    }
                    
                }
                
                
                
            } label: {
                withAnimation(.spring()){
                    Text(authViewModel.district.name)
                        .modifier(Fonts(fontName: .outfit_regular,
                                        colorName: .black,
                                        size: 20))
                    
                }
            }
            
            Divider()
                .padding(.top,-10)
                .padding(.bottom,2)
            
            Text("Commue")
                .modifier(Fonts(fontName: .outfit_regular,
                                colorName: .black,
                                size: 20))
                .padding(.bottom,2)
            
            Menu {
                ForEach(authViewModel.communes){
                    commune in
                    Button {
                        authViewModel.commune = commune
                        print(authViewModel.commune.name)
                    } label: {
                        Text(commune.name)
                            .modifier(Fonts(fontName: .outfit_regular,
                                            colorName: .black,
                                            size: 20))
                        
                    }
                    
                }
                
                
                
            } label: {
                withAnimation(.spring()){
                    Text(authViewModel.commune.name)
                        .modifier(Fonts(fontName: .outfit_regular,
                                        colorName: .black,
                                        size: 20))
                    
                }
            }
            
            Divider()
                .padding(.top,-10)
                .padding(.bottom,2)
            
            
            
            
        }
        .padding(.leading)
    }
    
    var addressField: some View {
        VStack(alignment: .leading){
            Text("Address")
                .modifier(Fonts(fontName: .outfit_regular,
                                colorName: .black,
                                size: 20))
                .padding(.bottom,2)
            TextField("",text: $authViewModel.address.street)
                .modifier(Fonts(fontName: .outfit_regular,
                                colorName: .black,
                                size: 20))
            Divider()
                .padding(.top,-10)
                .padding(.bottom,2)
        }
        .padding(.leading)
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
