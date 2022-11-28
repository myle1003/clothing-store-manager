//
//  AddressView.swift
//  H3MShop
//
//  Created by Lê Văn Huy on 10/11/2022.
//

import SwiftUI

struct AddressView: View {

    @Environment(\.presentationMode) var presentationMode
    @StateObject var vm = MyAddressViewModel()
    var customSize =  CustomSize()
    @Binding var infoAddress: InfoAddress
    @State var load: Bool = false
    
    var body: some View {
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
                            
                            Button {
                                self.infoAddress = info
                                presentationMode.wrappedValue.dismiss()
                            } label: {
                                AddressRowView(inforAddress: info)
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
        .onAppear(){
            self.load.toggle()
            vm.getInforAddress()
            self.load.toggle()
        }
        .navigationBarHidden(true)
        .background(Color(ColorsName.white.rawValue).opacity(0.05))
    }
}

//struct AddressView_Previews: PreviewProvider {
//    static var previews: some View {
//        AddressView()
//    }
//}

extension AddressView{
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
