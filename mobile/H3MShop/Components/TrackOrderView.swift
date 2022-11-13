//
//  TrackOrderView.swift
//  H3MShop
//
//  Created by Lê Văn Huy on 28/10/2022.
//

import SwiftUI

struct TrackOrderView: View {
    var customSize = CustomSize()
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack(alignment: .leading){
                header
            HStack{
                Spacer()
                Image("Profile.TrackOrder")
                    .resizable()
                    .scaledToFit()
                    .frame(height:350)
                Spacer()
            }
                
            VStack(alignment: .leading){
                    Text("Delivery Status")
                        .modifier(Fonts(fontName: .outfit_semibold, colorName: .black, size: 28))
                        .padding(.leading)
 
                StatusRow(image: "Profile.Accept", status: "Order is Accept", time: "13 Oct 12:50 PM")
                StatusRow(image: "Profile.Receive", status: "Order is being prepared", time: "15 Oct 7:20 AM")
                StatusRow(image: "Profile.Delivery", status: "Order will be delivery", time: "20 Oct 10:50 AM")
                    
                }
            
            HStack{
                Spacer()
                Text("View Detail Order")
                    .underline()
                    .modifier(Fonts(fontName: .outfit_regular,
                                    colorName: .green,
                                    size: 16))
                Spacer()
            }
            
                
                
                Spacer()
            }
        .navigationBarHidden(true)
        .background(Color(ColorsName.white.rawValue).opacity(0.05))

    }
}

struct TrackOrderView_Previews: PreviewProvider {
    static var previews: some View {
        TrackOrderView()
    }
}

extension TrackOrderView{
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
            
            Text("Track Order")
                .modifier(Fonts(fontName: .outfit_regular,
                                colorName: .black,
                                size: customSize.heightButtonList))
                .offset(x:-26)
            Spacer()
            
            
        }
        .padding(.leading)
        .offset(y:4)
    }

}
