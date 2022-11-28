//
//  AddNewAddress.swift
//  H3MShop
//
//  Created by Lê Văn Huy on 07/11/2022.
//

import SwiftUI

struct AddNewAddress: View {
    @Environment(\.presentationMode) var presentationMode
    
    var customSize =  CustomSize()
    var infoAddress: InfoAddress
    @State var fullname: String = ""
    @State var phone: String = ""
    @State var street: String = ""
    @State var role: Bool = false
    @StateObject var vm = MyAddressViewModel()
    @State var isLoad = false
    var body: some View {
        VStack(alignment: .leading){
           header
            
           Text("Contact")
                .padding(.leading)
                .modifier(Fonts(fontName: .outfit_regular,
                                colorName: .gray,
                                size: 16))
            
            
            VStack(spacing:0){
                TextField("Full Name", text: $fullname)
                    .padding()
                    .overlay(Rectangle()
                        .stroke(lineWidth: 0.3)
                        .foregroundColor(Color.gray)
                    )
                TextField("Phone Number", text: $phone)
                    .padding()
                    .overlay(Rectangle()
                        .stroke(lineWidth: 0.3)
                        .foregroundColor(Color.gray)
                    )
            }
            .modifier(Fonts(fontName: .outfit_regular,
                            colorName: .black,
                            size: 16))
            
            Text("Address")
                 .padding(.leading)
                 .modifier(Fonts(fontName: .outfit_regular,
                                 colorName: .gray,
                                 size: 16))
            
            VStack(alignment:.leading,spacing: 10){
                
                Divider()
                    .padding(.leading,-24)
                    .padding(.trailing,-24)
                Menu {
                    ForEach(vm.provinces){
                        province in
                        Button {
                            Task{
                                do{
                                    vm.province = province
                                    try await vm.getDistrict(id_province: province._id)
                                    try await vm.getCommune(id_district: vm.district._id)
                                }
                                catch{
                                    
                                }
                            }
                            
                        } label: {
                            Text(province.name)
                                .scaledToFit()
                                .modifier(Fonts(fontName: .outfit_regular,
                                                colorName: .black,
                                                size: 16))
                            
                        }
                        
                    }
                    
                    
                    
                } label: {
                    withAnimation(.spring()){
                        Text(vm.province.name)
                            .modifier(Fonts(fontName: .outfit_regular,
                                            colorName: .black,
                                            size: 16))
                        
                    }
                }
                Divider()
                    .padding(.leading,-24)
                    .padding(.trailing,-24)
                
                
                Menu {
                    ForEach(vm.districts){
                        district in
                        Button {
                            Task{
                                do{
                                    vm.district = district
                                    try await vm.getCommune(id_district: district._id)
                                }
                                catch{
                                    
                                }
                            }
                            
                        } label: {
                            Text(district.name)
                                .scaledToFit()
                                .modifier(Fonts(fontName: .outfit_regular,
                                                colorName: .black,
                                                size: 16))
                            
                        }
                        
                    }
                    
                    
                    
                } label: {
                    withAnimation(.spring()){
                        Text(vm.district.name)
                            .modifier(Fonts(fontName: .outfit_regular,
                                            colorName: .black,
                                            size: 16))

                    }
                }
                
                Divider()
                    .padding(.leading,-24)
                    .padding(.trailing,-24)
                
                Menu {
                    ForEach(vm.communes){
                        commune in
                        Button {
                            vm.commune = commune
                            
                        } label: {
                            Text(commune.name)
                                .modifier(Fonts(fontName: .outfit_regular,
                                                colorName: .black,
                                                size: 16))
                            
                        }
                        
                    }
                    
                    
                    
                } label: {
                    withAnimation(.spring()){
                        Text(vm.commune.name)
                            .scaledToFit()
                            .modifier(Fonts(fontName: .outfit_regular,
                                            colorName: .black,
                                            size: 16))
                        
                    }
                }
                
                
                

            }
            .padding(.leading)
            .modifier(Fonts(fontName: .outfit_regular,
                            colorName: .black,
                            size: 16))
            
            TextField("Street", text: $street)
                .padding()
                .overlay(Rectangle()
                    .stroke(lineWidth: 0.3)
                    .foregroundColor(Color.gray)
                )
                .padding(.top,2)
            
            
            Text("Set Default")
                 .padding(.leading)
                 .modifier(Fonts(fontName: .outfit_regular,
                                 colorName: .gray,
                                 size: 16))
            
            Text("Default")
                .modifier(Fonts(fontName: .outfit_regular,
                                colorName: self.role == true ? .red : .black,
                                size: 16))
                .frame(width: 80,height: 24)
                .onTapGesture {
                    self.role.toggle()
                }
                .overlay(
                Rectangle()
                    .stroke(lineWidth: 0.5)
                    .foregroundColor(Color.red)
                )
                .padding(.leading)
            
            Button {
                Task{
                    do{
                        if self.infoAddress._id == "" {
                            try await vm.addInforAddress(name: fullname, phone: phone, address: Address(id_province: vm.province._id,id_district: vm.district._id,id_commune:vm.commune._id,street: street), role: role)
                            
                            presentationMode.wrappedValue.dismiss()
                        }
                        
                        else {
                            try await vm.editInforAddress(name: fullname, phone: phone, address: Address(id_province: vm.province._id,id_district: vm.district._id,id_commune:vm.commune._id,street: street), role: role,id: infoAddress._id)
                            
                            presentationMode.wrappedValue.dismiss()
                        }
                    }
                    catch{
                        
                    }
                }
            } label: {
                HStack{
                    Spacer()
                    Text("SUBMIT")
                        .modifier(Fonts(fontName: .outfit_regular,
                                        colorName: .white,
                                        size: 20))
                    Spacer()
                }
                .frame(height: 40)
                .background(Color.orange)
                .padding()
            }

            
            Spacer()
        }
        .onAppear(){
            Task{
                do{
                    isLoad.toggle()
                    self.fullname = infoAddress.name
                    self.phone = infoAddress.phone
                    self.street = infoAddress.address.street
                    try await vm.getDistrict(id_province: infoAddress.address.id_province._id)
                    try await vm.getCommune(id_district: infoAddress.address.id_district._id)
                    
                    vm.province = infoAddress.address.id_province
                    vm.district = infoAddress.address.id_district
                    vm.commune = infoAddress.address.id_commune
                    
                    isLoad.toggle()
                }
                catch{
                    
                }
            }
            
        }
        .navigationBarHidden(true)
    }
}

struct AddNewAddress_Previews: PreviewProvider {
    static var previews: some View {
        AddNewAddress(infoAddress: InfoAddress())
    }
}

extension AddNewAddress{
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
            
            Text("New Address")
                .modifier(Fonts(fontName: .outfit_regular,
                                colorName: .black,
                                size: customSize.heightButtonList))
                .offset(x:-8)
            Spacer()
            
            
        }
        .padding(.leading)
        .padding(.trailing)
        
    }
}
