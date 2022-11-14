//
//  NotificationRow.swift
//  H3MShop
//
//  Created by Van Huy on 18/10/2022.
//

import SwiftUI

struct NotificationRow: View {
    var image: String
    var name: String
    var descrip: String
    var body: some View {
        VStack{
            
            HStack{
                Image(image)
                    .resizable()
                    .frame(width:35,height:35)
                    .overlay(Circle()
                        .stroke(lineWidth: 0.1)
                        .frame(width:50,height:50)
                             
                    )
                VStack(alignment: .leading){
                    Text(name)
                        .modifier(Fonts(fontName: .outfit_regular,
                                        colorName: .black,
                                        size: 20))
                    Text(descrip)
                        .modifier(Fonts(fontName: .outfit_thin,
                                        colorName: .black,
                                        size: 14))
                }
                .padding()
                
                Spacer()
                Button {
                    //MARK: LINK TO .....
                } label: {
                    Image(systemName: "chevron.right")
                        .font(.title3)
                        .foregroundColor(Color.black)
                        .padding()
                }

            }
            .padding(.leading)
            .frame(height: 60)
            .background(Color(ColorsName.white.rawValue))
            Divider()
                .frame(height:5)
                .padding(.top,-8)
            
        }
    }
}

struct NotificationRow_Previews: PreviewProvider {
    static var previews: some View {
        NotificationRow(image: "Notification.Sale",
                        name: "Promotion",
                        descrip: "Promotion code is here now")
    }
}
