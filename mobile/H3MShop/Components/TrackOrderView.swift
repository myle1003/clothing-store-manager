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
    var history: [History]
    
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

                ForEach(self.history){history in
                    StatusRow(status: history.id_status.name, time: history.date)
                }
                    
                }
            
            
                
                
                Spacer()
            }
        .navigationBarHidden(true)
        .background(Color(ColorsName.white.rawValue).opacity(0.05))

    }
}

struct TrackOrderView_Previews: PreviewProvider {
    static var previews: some View {
        TrackOrderView(history: [])
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
