//
//  EditRow.swift
//  H3MShop
//
//  Created by Lê Văn Huy on 28/10/2022.
//

import SwiftUI

struct EditRow: View {
    var image: String
    var name: String
    var body: some View {
        HStack(){
            Image(image)
                .resizable()
                .frame(width: 25,height: 25)
            Text(name)
                .modifier(Fonts(fontName: .outfit_regular,
                                colorName: .black,
                                size: 20))
            Spacer()
            Image("Profile.next")
                .resizable()
                .frame(width: 20,height: 20)
        }
        .padding(.leading)
    }
}

struct EditRow_Previews: PreviewProvider {
    static var previews: some View {
        EditRow(image: "Profile.edit", name: "Edit Profile")
    }
}
