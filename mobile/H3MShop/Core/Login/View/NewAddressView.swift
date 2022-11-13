//
//  NewAddressView.swift
//  H3MShop
//
//  Created by Lê Văn Huy on 03/11/2022.
//

import SwiftUI

struct NewAddressView: View {
    var customSize = CustomSize()
    @EnvironmentObject var authViewModel: Authentincation
    @State var isWait: Bool = false
    @State var animate = false
    var body: some View {
        ZStack{
            VStack{
                header
                
                image
                
                VStack{
                    editRow
                    addressField
                }
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
        }
        .navigationBarHidden(true)
        .background(Color(ColorsName.white.rawValue).opacity(0.05))
    }
}

struct NewAddressView_Previews: PreviewProvider {
    static var previews: some View {
        NewAddressView()
            .environmentObject(Authentincation())
    }
}

extension NewAddressView {
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
                Text("Please fill your address")
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

