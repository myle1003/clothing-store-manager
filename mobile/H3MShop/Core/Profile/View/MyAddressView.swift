//
//  MyAddressView.swift
//  H3MShop
//
//  Created by Lê Văn Huy on 07/11/2022.
//

import SwiftUI

struct MyAddressView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @StateObject var vm = MyAddressViewModel()
    var customSize =  CustomSize()
    @State var load: Bool = false
    @State var isNotDelete = false
    
    
    var body: some View {
        VStack{
            
            if isNotDelete {
                notification
            }
            
            else{
                VStack(alignment: .leading,spacing: 1){
                    
                    if load{
                        Loader()
                    }
                    
                    else{
                        VStack(alignment: .leading){
                            header
                            
                            Text("Address")
                                .modifier(Fonts(fontName: .outfit_regular,
                                                colorName: .black,
                                                size: 20))
                                .padding()
                            
                            
                            ScrollView{
                                ForEach(vm.infoAddress) { info  in
                                    
                                    NavigationLink {
                                        AddNewAddress(infoAddress: info)
                                    } label: {
                                        AddressRowEditView(inforAddress: info, isNotDelete: $isNotDelete)
                                    }

                                    
                                }
                                
                                
                                NavigationLink(destination: AddNewAddress(infoAddress: InfoAddress()), label: {
                                    HStack{
                                        Spacer()
                                        Image(systemName: "plus.circle")
                                        Text("Add New Address")
                                        Spacer()
                                    }
                                    .modifier(Fonts(fontName: .outfit_regular,
                                                    colorName: .listCategory,
                                                    size: 20))
                                })
                                
                                .padding()
                            }
                            
                            
                            
                            Spacer()
                        }
                    }
                    
                }
            }
        }
        .onAppear(){
            self.load.toggle()
            vm.getInforAddress()
            self.load.toggle()
        }
        .onChange(of: vm.infoAddress, perform: { newValue in
            vm.getInforAddress()
        })
        .navigationBarHidden(true)
        .background(Color(ColorsName.white.rawValue).opacity(0.05))
    }
}

struct MyAddressView_Previews: PreviewProvider {
    static var previews: some View {
        MyAddressView()
    }
}

extension MyAddressView {
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
            
            Text("My Address")
                .modifier(Fonts(fontName: .outfit_regular,
                                colorName: .black,
                                size: customSize.heightButtonList))
                .offset(x:-8)
            Spacer()
            
            
        }
        .padding(.leading)
        .padding(.trailing)
        
    }
    
    
    var notification : some View {
        VStack(){
            Text("Warning")
                .modifier(Fonts(fontName: .outfit_regular, colorName: .purple, size: 26))
            
            Text("You can not delete default Addresss")
                .multilineTextAlignment(.center)
                .frame(height: 40)
                .lineLimit(2)
                .padding(.leading)
                .padding(.trailing)
                .modifier(Fonts(fontName: .outfit_regular, colorName: .red, size: 12))
                .offset(y:-12)
            
        
            
            
            Button {
                isNotDelete = false
            } label: {
                Text("OK")
                    .frame(width: 80,height: 30)
                    .background(LinearGradient(colors: [Color(ColorsName.purple.rawValue),Color(ColorsName.blue.rawValue)], startPoint: .top, endPoint: .bottom))
                    .modifier(Fonts(fontName: .outfit_bold, colorName: .white, size: 15))
                    .padding(.bottom,10)
            }
        }
        .frame(width: 200,height: 200)
        .background(Color(ColorsName.alert.rawValue))
        .cornerRadius(20)
        .shadow(radius: 5)
    }
    
}

