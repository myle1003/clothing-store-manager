//
//  MainView.swift
//  H3MShop
//
//  Created by Van Huy on 15/10/2022.
//

import SwiftUI

struct MainView: View {
    
    @StateObject var vm = MainViewModel()
    @StateObject var authViewModel = Authentincation()
    
    
    @State var indexImage: Int = -1
    @State var titleCategory: String = "Popular Product"
    @State var load = false
    @State var isSearch = false
    var sortOptions = ["Lasted Product","Oldest Product","Low to High","High to Low"]
    
    var customSize = CustomSize()
    var body: some View {
        VStack{
            
            if isSearch {
                withAnimation(.easeIn(duration: 1)){
                    SearchView(isSearch: $isSearch)
                        .frame(width: isSearch ? .infinity : 0,height: isSearch ? .infinity : 0)
                }
            }
            
            else{
                
                VStack{
                    header
                    
                    search
                    
                    category
                    
                    title
                    
                    listProduct
                    
                    Spacer()
                }
            }
            
            
        }
        .background(Color(ColorsName.white.rawValue).opacity(0.05))
}
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
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
            SearchBarView(text: $vm.textSearch)
                .onTapGesture {
                    self.isSearch.toggle()
                }
            
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
            Text(titleCategory.uppercased())
                .modifier(Fonts(fontName: .outfit_bold,
                                colorName: .black,
                                size: 20))
            Spacer()
            Button {
                load.toggle()
                self.indexImage = -1
               vm.getProducts()
                self.titleCategory = "Total Product"
                load.toggle()
            } label: {
                Text("View All")
                    .modifier(Fonts(fontName: .outfit_bold,
                                    colorName: .gray,
                                    size: customSize.textLoginSize))
            }

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
            
            if vm.recentCount < vm.totalCount {
                
                
                VStack(spacing: 5){
                    Button {
                        Task{
                            do{
                                vm.recentCount += 1
                                try await vm.fetchMoreProduct()
                            }
                            catch{
                                
                            }
                        }
                        
                    } label: {
                        Text("View More")
                            .modifier(Fonts(fontName: .outfit_regular,
                                            colorName: .black,
                                            size: 20))
                        Image(systemName: "chevron.down")
                            .modifier(Fonts(fontName: .outfit_regular,
                                            colorName: .black,
                                            size: customSize.titleLoginSize))
                    }

                }
                .padding()
            }
            
        }
        
    }
}
