//
//  MainTabView.swift
//  H3MShop
//
//  Created by Van Huy on 18/10/2022.
//

import SwiftUI

struct MainTabView: View {
    
    @State var selectedIndex = 0
    @State var isLoad = true
    @EnvironmentObject var authViewModel : Authentincation
    
    var body: some View {
        VStack{
            
            if isLoad{
                Loader()
            }
            else
            {
                VStack{
                    if selectedIndex == 0 {
                        MainView()
                    }
                    else if selectedIndex == 1 {
                        WishListView()
                    }
                    else if selectedIndex == 2 {
                        NotificationView()
                    }
                    else if selectedIndex == 3 {
                        ProfileView()
                            .padding(.bottom,16)
                    }
                    
                    Spacer()
                    TabBarView(selectedIndex: $selectedIndex)
                        .frame(height: 64)
                }
            }
            
        }
        .onAppear(){
            authViewModel.getCart()
            self.isLoad = false
        }

        .background(Color(ColorsName.white.rawValue).opacity(0.05))
        
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
            .environmentObject(Authentincation())
        
    }
}
