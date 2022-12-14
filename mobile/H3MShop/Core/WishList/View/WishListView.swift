//
//  WishListView.swift
//  H3MShop
//
//  Created by Van Huy on 18/10/2022.
//

import SwiftUI

struct WishListView: View {
    @State var textSearch = ""
    var customSize = CustomSize()
    @StateObject var vm = MainViewModel()
    var body: some View {
        VStack{
            header
            search
            title
            listWishList
            Spacer()
        }
        .background(Color(ColorsName.white.rawValue).opacity(0.05))
    }
}

struct WishListView_Previews: PreviewProvider {
    static var previews: some View {
        WishListView()
    }
}
extension WishListView {
    var header: some View {
        HStack{
            Button {
                //MARK: GO TO MENU
            } label: {
                Image("Main.Menu")
                    .resizable()
                    .frame(width: customSize.heightButtonList,
                           height: customSize.heightButtonList)
            }
            
            Spacer()
            Text("H3M")
                .modifier(Fonts(fontName: .outfit_regular,
                                colorName: .black,
                                size: customSize.heightButtonList))
            Spacer()
            Button {
                //MARK: GO TO WISHLIST
            } label: {
                Image(systemName: "bag")
                    .font(.title3)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.purple)
                    .clipShape(Circle())
                    .overlay(
                    Text("1")
                        .font(.caption)
                        .fontWeight(.bold)
                        .foregroundColor(Color.white)
                        .padding(10)
                        .background(Color.red)
                        .clipShape(Circle())
                        .offset(x:15,y:-20)
                    )
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
    var title: some View {
        HStack{
            Text("Wish List")
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
    
    var listWishList: some View{
        
        ScrollView{
            LazyVGrid(columns:[
                GridItem(.adaptive(minimum: 190))
            ]) {
                ForEach(vm.wishlist){ product in
                    
                    NavigationLink {
                        DetailView(slug: product.id_product.slug)
                    } label: {
                        WishListRow(name: product.id_product.name,category: "", urlImage: product.id_product.urlImage.isEmpty ?  "" : product.id_product.urlImage[0], price: product.id_product.price - (product.id_product.price * product.id_product.discount)/100,discount: product.id_product.discount, sold: product.id_product.sold,rate: Int(product.rate))
                    }


                    
                }
            }
        }
    }
}
