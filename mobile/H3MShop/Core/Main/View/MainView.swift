//
//  MainView.swift
//  H3MShop
//
//  Created by Van Huy on 15/10/2022.
//

import SwiftUI

struct MainView: View {
    
    @ObservedObject var vm = MainViewModel()
    @EnvironmentObject var authViewModel: Authentincation
    
    @State var textSearch = ""
    @State var indexImage: Int = -1
    @State var titleCategory: String = "Popular Product"
    @State var load = false
    
    var customSize = CustomSize()
    var body: some View {
        VStack{
            
            header
            
            search
            
            category
            
            title
            
            listProduct
            
            Spacer()
            
            
        }
        .background(Color(ColorsName.white.rawValue).opacity(0.05))
}
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .environmentObject(Authentincation())
    }
}

extension MainView {
    
    var header: some View {
        HStack{
            Button {
                //MARK: GO TO MENU
            } label: {
                Image("Main.Menu")
                    .resizable()
                    .frame(width: customSize.widthButtonList,
                           height: customSize.heightButtonList)
            }
            
            Spacer()
            Text("H3M")
                .modifier(Fonts(fontName: .outfit_regular,
                                colorName: .black,
                                size: customSize.heightButtonList))
            Spacer()
            Button {
                //MARK: GO TO WISHLISH
            } label: {
                Image("Main.WishList")
                    .resizable()
                    .frame(width: customSize.mainButtonDetail,
                           height: customSize.mainButtonDetail)
            }
            
            
        }
        .padding(.leading)
        .padding(.trailing)
    }
    
    var search: some View {
        HStack{
            SearchBarView(text: $textSearch)
            Button {
                //MARK: SORT
            } label: {
                Image("Main.Sort")
                    .resizable()
                    .frame(width: customSize.mainButtonListCart,
                           height: customSize.mainButtonListCart)
                    .padding()
            }
            
        }
    }
    
    var category: some View {
        ScrollView(.horizontal,showsIndicators: false) {
            LazyHStack{
                ForEach(Array(zip(vm.categories,
                                  vm.categories.indices)),id:\.1){ category,index in
                    Button {
                        indexImage = index
                        self.titleCategory = category.name
                        load.toggle()
                        vm.getProductbyCategory(slug: category.slug)
                        load.toggle()
                    } label: {
                        CategoryView(indexImage: $indexImage,
                                     index: index,
                                     name: category.name)
                    }
                    
                }
            }
            .padding()
        }
        .frame(height:customSize.heightCategory)
    }
    
    var title: some View {
        HStack{
            Text(titleCategory)
                .modifier(Fonts(fontName: .outfit_bold,
                                colorName: .black,
                                size: customSize.titleLoginSize))
            Spacer()
            Text("View All")
                .modifier(Fonts(fontName: .outfit_bold,
                                colorName: .gray,
                                size: customSize.textLoginSize))
        }
        .padding()
    }
    
    var listProduct: some View{
        ScrollView{
            if self.load {
                Loader()
                    .frame(width: 100,height: 100)
            }
            else{
                LazyVGrid(columns:[
                    GridItem(.adaptive(minimum: 190))
                ]) {
                    ForEach(vm.products){ product in
                        NavigationLink(destination: DetailView(product:product)) {
                            ProductView(name: product.name, category: vm.categories.filter{$0._id == product.id_cate}.first?.name ?? "", urlImage: product.urlImage[0], price: product.price - (product.price * product.discount)/100,discount: product.discount, sold: product.sold)
                        }

                        
                    }
                }
            }
        }
        
    }
}
