//
//  SearchView.swift
//  H3MShop
//
//  Created by Lê Văn Huy on 13/11/2022.
//

import SwiftUI

struct SearchView: View {
    @StateObject var vm = MainViewModel()
    var customSize = CustomSize()
    @Binding var isSearch: Bool
    var sortOptions = ["Lasted Product","Oldest Product","Low to High","High to Low"]
    
    var body: some View {
        VStack(alignment: .leading){
            header
            search
            
            
            VStack(alignment: .leading){
                Text("Search Suggestion")
                    .modifier(Fonts(fontName: .outfit_regular,
                                    colorName: .black,
                                    size: 24))
                ScrollView(.horizontal,showsIndicators: false){
                    HStack{
                        Button {
                            //
                        } label: {
                            HStack{
                                Image("Category0")
                                    .resizable()
                                    .frame(width: 50,height: 50)
                                Text("Áo khoác")
                                    .modifier(Fonts(fontName: .outfit_regular,
                                                    colorName: .black,
                                                    size: 16))
                            }
                            .padding()
                            .overlay(Rectangle().stroke(lineWidth: 0.5))
                        }
                        
                        Button {
                            //
                        } label: {
                            HStack{
                                Image("Category2")
                                    .resizable()
                                    .frame(width: 50,height: 50)
                                Text("Áo Sơ Mi")
                                    .modifier(Fonts(fontName: .outfit_regular,
                                                    colorName: .black,
                                                    size: 16))
                            }
                            .padding()
                            .overlay(Rectangle().stroke(lineWidth: 0.5))
                        }
                        
                        Button {
                            //
                        } label: {
                            HStack{
                                Image("Category3")
                                    .resizable()
                                    .frame(width: 50,height: 50)
                                Text("Áo Nely")
                                    .modifier(Fonts(fontName: .outfit_regular,
                                                    colorName: .black,
                                                    size: 16))
                            }
                            .padding()
                            .overlay(Rectangle().stroke(lineWidth: 0.5))
                        }

                    }
                }
                
                
            }
            .padding(.leading)
            
            Spacer()
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView(isSearch: .constant(true))
    }
}
extension SearchView{
    
    var header: some View {
        VStack{
            HStack{
                Button {
                    //MARK: GO TO PROFILE
                    self.isSearch = false
                } label: {
                    Image("Main.back")
                        .resizable()
                        .frame(width: customSize.mainButtonDetail,
                               height: customSize.mainButtonDetail)
                }
                Spacer()
                
                
            }
            .padding(.leading)
            .padding(.trailing)
        }
    }
    
    var search: some View {
        HStack{
            SearchBarView(text: $vm.textSearch)
            
            Menu {
                ForEach(sortOptions,id: \.self){
                    sort in
                    Button {
                    } label: {
                        Text(sort)
                            .modifier(Fonts(fontName: .outfit_regular,
                                            colorName: .black,
                                            size: 20))
                            
                    }

                }
                
                
            } label: {
                Image("Main.Sort")
                    .resizable()
                    .frame(width: customSize.mainButtonListCart,
                           height: customSize.mainButtonListCart)
                    .padding()
            }
        }
    }
}
