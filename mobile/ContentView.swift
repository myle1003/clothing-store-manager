//
//  ContentView.swift
//  H3MShop
//
//  Created by Van Huy on 05/10/2022.
//

import SwiftUI

struct ContentView: View {
    @StateObject var authViewModel = Authentincation()
    @State var isquery: Bool = false
    var body: some View {
        VStack{
            if isquery == true {
                if authViewModel.currenUser != nil {
                    MainTabView()
                }
                else {
                    SplashView()
                }
            }
            else {
                Logo()
            }
        }
        .onChange(of: authViewModel.currenUser, perform: { _ in
            isquery = true
        })
        .navigationBarHidden(true)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
