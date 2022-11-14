//
//  TabBarView.swift
//  H3MShop
//
//  Created by Van Huy on 15/10/2022.
//

import SwiftUI

struct TabBarView: View {
    
    @Binding var selectedIndex: Int
    var customSize = CustomSize()
    @StateObject var vm = CartViewModel()
    
    var body: some View {
        VStack{
            Image("Main.tabbar")
                .resizable()
                .frame(width:450,height: 0)
                .padding(.bottom,-12)
                .overlay(
                    VStack{
                        HStack{
                            
                            Button {
                                //MARK: GO TO MAIN HOME
                                self.selectedIndex = 0
                            } label: {
                                withAnimation{
                                    Image(self.selectedIndex == 0 ? "Main.HomeFill" : "Main.Home")
                                        .resizable()
                                        .frame(width:customSize.mainButtonSize,
                                               height:customSize.mainButtonSize)
                                        .padding()
                                }
                            }

                            
                            Button {
                                //MARK: GO TO WISHLIST
                                self.selectedIndex = 1
                            } label: {
                                withAnimation{
                                    Image(self.selectedIndex == 1 ? "Main.HeartFill" : "Main.Heart")
                                        .resizable()
                                        .frame(width:customSize.mainButtonSize,
                                               height:customSize.mainButtonSize)
                                        .padding()
                                }
                            }

                            
                            NavigationLink(destination: CartView(), label: {
                            label: do {
                                Image("Main.Cart")
                                    .resizable()
                                    .frame(width:customSize.mainButtonCartSize,
                                           height:customSize.mainButtonCartSize)
                                    .offset(x:0,y:-16)
                                    .overlay(
                                    Text("\(vm.carts.cart.product.count)")
                                        .font(.caption)
                                        .fontWeight(.bold)
                                        .foregroundColor(Color.white)
                                        .padding(10)
                                        .background(Color.red)
                                        .clipShape(Circle())
                                        .offset(x:15,y:-45)
                                    )
                            }
                            })
                            
                            Button {
                                //MARK: GO TO NOTIFICATION
                                self.selectedIndex = 2
                            } label: {
                                withAnimation{
                                    Image(self.selectedIndex == 2 ? "Main.NotificationFill" : "Main.Notification")
                                        .resizable()
                                        .frame(width:customSize.mainButtonSize,
                                               height:customSize.mainButtonSize)
                                        .padding()
                                        .overlay(
                                            Text("1")
                                            .font(.caption)
                                            .fontWeight(.bold)
                                            .foregroundColor(Color.white)
                                            .padding(4)
                                            .background(Color.red)
                                            .clipShape(Circle())
                                            .offset(x:12,y:-20)
                                        )
                                }
                            }
                            
                            
                            Button {
                                //MARK: GO TO PROFILE
                                self.selectedIndex = 3
                            } label: {
                                withAnimation{
                                    Image(self.selectedIndex == 3 ? "Main.ProfileFill" : "Main.Profile")
                                        .resizable()
                                        .frame(width:customSize.mainButtonSize,
                                               height:customSize.mainButtonSize)
                                        .padding()
                                }
                            }

                        }
                            
                    }
                )
                
                
        }
        .onAppear(){
            vm.getCart()
        }
        .navigationBarHidden(true)
    }
       
}

struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView(selectedIndex: .constant(0))
    }
}
