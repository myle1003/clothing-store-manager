//
//  DetailView.swift
//  H3MShop
//
//  Created by Van Huy on 17/10/2022.
//

import SwiftUI
import Kingfisher
struct DetailView: View {
    
    @StateObject var vm = DetailViewModel()
    
    @State var x: CGFloat = 0
    @State var count: CGFloat = 1
    @State var screen = UIScreen.main.bounds.width - 80
    @State var currentAmount: CGFloat = 0
    
    @State var quantity: Int = 0
    @State var chooseSize: String = ""
    @State var chooseColor: String = ""
    @State var isChoose: Bool = false
    @State var isLoad: Bool = true
    //Moving Image To Top like Hero Animation....
    @Namespace var animation: Namespace.ID
    
    @Environment(\.presentationMode) var presentationMode
    
    @StateObject var vmCart = CartViewModel()
    
    
    var customSize = CustomSize()
    var product: Product
    
    var body: some View {
        VStack(){
            
            if isLoad {
                Loader()
            }
            else{
                VStack{
                    //MARK: ANIMATION
                    if vm.startAnimation {
                        VStack{
                            
                            Spacer()
                            ZStack{
                                //Circle Animation Effect
                                Color.white
                                    .frame(width:vm.shoesAnimation ? 100 : getRect().width * 1.3,
                                           height:vm.shoesAnimation ? 100 : getRect().width * 1.3
                                    )
                                    .clipShape(Circle())
                                    .opacity(vm.shoesAnimation ? 1: 0)
                                
                                //
                                KFImage(URL(string: product.urlImage[0]))
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .matchedGeometryEffect(id: "SHOES", in: animation)
                                    .frame(width:80,height:80)
                                    .cornerRadius(80)
                                
                            }
                            .offset(y:vm.saveCart ? 960 : 200)
                            .scaleEffect(vm.saveCart ? 0.55 : 1)
                            .onAppear(perform: vm.performAnimation)
                            
                            if !vm.saveCart {
                                Spacer()
                            }
                            
                            Image(systemName: "bag\(vm.addItemToCart ? ".fill" : "" )")
                                .font(.title)
                                .foregroundColor(.white)
                                .padding()
                                .background(vm.addItemToCart ? Color.purple : Color.orange)
                                .clipShape(Circle())
                                .offset(y:vm.showBag ? 450 : 900)
                            
                            
                        }
                        .frame(width:getRect().width)
                        .offset(y:vm.endAnimation ? 500 : 0)
                        
                    }
                    
                    VStack(){
                        
                        header
                        
                        image
                        
                        
                        ScrollView(.vertical,showsIndicators: false){
                            
                            
                            detail
                            choose
                                .padding(.bottom,2)
                            review
                        }
                        Spacer()
                        
                        addToCart
                        
                    }
                    .blur(radius: vm.startAnimation ? 50 : 0)
                }
            }
            
            
            
            
        }
        .onAppear(){
            Task{
                do{
                    try await vm.fetchProductDetail(slug: product.slug)
                    self.isLoad = false
                }
            }
        }
        .onChange(of: chooseSize, perform: { _ in
            if self.chooseSize != "" && self.chooseColor != "" {
                Task{
                    do {
                        try await vm.fetchProductDetail(slug: product.slug)
                        self.isChoose = true
                        
                    }
                    catch{
                        
                    }
                }
            }
        })
        .onChange(of: chooseColor, perform: { _ in
            if self.chooseSize != "" && self.chooseColor != "" {
                Task{
                    do {
                        try await vm.fetchProductDetail(slug: product.slug)
                        self.isChoose = true
                        
                    }
                    catch{
                        
                    }
                }
            }})
        .background(Color(ColorsName.white.rawValue).opacity(0.05))
        .onChange(of: vm.endAnimation, perform: { value in
            if vm.endAnimation {
                vm.resetAll()
            }
        })
        .navigationBarHidden(true)
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(product: Product(_id: "", name: "le Van Huy", rate: 3, status: "", slug: "", urlImage: ["https://w0.peakpx.com/wallpaper/678/107/HD-wallpaper-cute-animation-couple-goals-couple-kiss-couple-love-cute-couple-kiss-kissing-love-love-2019-make-love.jpg","https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR0hb6tnldzMaJyOCflPX8eh18d9fFzrhN3vg&usqp=CAU","https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR0hb6tnldzMaJyOCflPX8eh18d9fFzrhN3vg&usqp=CAU"], sold: 2, id_cate: "", size: [], color: [], description: "sjsjjsjsjsjssjsjsjsjsjsjsjsjsjsjsjsjsjsjsjsjsjsjsjssjsjsjsjsjsjsj", price: 300000, sellDay: "", weight: 2, discount: 15))
    }
}
extension DetailView{
    var header: some View {
        HStack{
            Button {
                presentationMode.wrappedValue.dismiss()
            } label: {
                Image("Main.back")
                    .resizable()
                    .frame(width: customSize.mainButtonDetail,
                           height: customSize.mainButtonDetail)
            }
            
            Spacer()
            Text("H3M")
                .modifier(Fonts(fontName: .outfit_regular,
                                colorName: .black,
                                size: customSize.heightButtonList))
            Spacer()
            
            NavigationLink(destination: CartView()) {
                Image(systemName: "bag")
                    .font(.title3)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.purple)
                    .clipShape(Circle())
                    .overlay(
                        Text("\(vmCart.carts.cart.product.count)")
                            .font(.caption)
                            .fontWeight(.bold)
                            .foregroundColor(Color.white)
                            .padding(8)
                            .background(Color.red)
                            .clipShape(Circle())
                            .offset(x:15,y:-20)
                    )
            }
            
            
        }
        .padding(.leading)
        .padding(.trailing)
    }
    
    var image: some View {
        VStack(spacing:15){
            if !vm.startAnimation{
                
                Spacer()
                
                LazyHStack(spacing:40){
                    
                    ForEach(product.urlImage,id:\.self){ urlImage in
                        
                        CardView(currentAmount: $currentAmount, urlImage: urlImage)
                            .offset(x:self.x)
                            .highPriorityGesture(DragGesture()
                                .onChanged({ value in
                                    
                                    if value.translation.width > 0 {
                                        self.x = value.location.x
                                    }
                                    else{
                                        self.x = value.location.x - self.screen
                                    }
                                
                                })
                                    .onEnded({ value in
                                        if value.translation.width > 0 {
                                            if value.translation.width > ((self.screen) - 200 / 2) && Int(self.count) != self.getMid() {
                                                self.count += 1
                                                self.x = (self.screen + 40 ) * self.count
                                            }
                                            else {
                                                self.x = (self.screen + 40) * self.count
                                            }
                                        }
                                        else {
                                            if -value.translation.width > -((self.screen) - 200 / 2) && -Int(self.count) != self.getMid() {
                                                self.count -= 1
                                                self.x = (self.screen + 40 ) * self.count
                                            }
                                            else {
                                                self.x = (self.screen + 40) * self.count
                                            }

                                        }
                                    })
                                  
                                                 
                            )
                        
                    }
                }
                
            }
            Spacer()
        }
        .animation(.spring())
        .frame(height:300)
    }
    
    func getMid()-> Int {
        return product.urlImage.count / 2
        
    }
    
    
    var detail: some View{
        VStack(alignment: .leading){
            HStack{
                Text(product.name)
                    .modifier(Fonts(fontName: .outfit_regular,
                                    colorName: .black,
                                    size: customSize.titleLoginSize))
                Image("Main.star")
                    .resizable()
                    .frame(width:customSize.textButton,
                           height:customSize.textButton)
                Text("\((vm.productDetail.rate.rate * 10)/10.00)")
                    .modifier(Fonts(fontName: .outfit_thin,
                                    colorName: .gray,
                                    size: customSize.textPrice))
                
                

                Spacer()
                
            }
            
            HStack{
                Text("Price:")
                    .modifier(Fonts(fontName: .outfit_regular,
                                    colorName: .black,
                                    size: 24))
                Text("\(product.price - (product.price * product.discount)/100) đ")
                    .modifier(Fonts(fontName: .outfit_regular,
                                    colorName: .red,
                                    size: 24))
                    .padding(.trailing)
                Text("Sold:")
                    .modifier(Fonts(fontName: .outfit_regular,
                                    colorName: .black,
                                    size: 16))
                Text("\(product.sold)")
                    .modifier(Fonts(fontName: .outfit_regular,
                                    colorName: .black,
                                    size: 16))
                
                 Image("Main.discount")
                    .resizable()
                    .frame(width: 60,height: 80)
                    .overlay(
                        Text("\(product.discount)%")
                        .offset(y:-4)
                        .modifier(Fonts(fontName: .outfit_bold,
                                        colorName: .red,
                                        size: 20))
                    )
                    .offset(x:32,y:-10)
            }
            .padding(.top,-24)
            
            Text("\(product.price) đ")
                .strikethrough()
                .modifier(Fonts(fontName: .outfit_regular,
                                colorName: .gray,
                                size: 20))
                .padding(.top,-24)
                .offset(x:72,y:-16)
            
            Text(product.description)
                .modifier(Fonts(fontName: .outfit_light,
                                colorName: .black,
                                size: 14))
                .lineLimit(5)
                .offset(y:-20)
                .frame(height: 100)
            
        }
        .padding(.top)
        .padding(.leading)
        .padding(.trailing)
        
    }
    
    var choose: some View {
        VStack(alignment:.leading){
            Text("Size:")
                .modifier(Fonts(fontName: .outfit_regular,
                                colorName: .black,
                                size: 20))
                .padding(.leading)
                .padding(.top)
            VStack{
                ForEach(product.size){ size in
                    HStack{
                        Button {
                            self.chooseSize = size._id
                        } label: {
                            RoundedRectangle(cornerRadius: 2)
                                .stroke(lineWidth: 1)
                                .frame(width: 50, height: 30)
                                .foregroundColor(Color(self.chooseSize == size._id ? ColorsName.red.rawValue : ColorsName.purple.rawValue))
                                .overlay(
                                    Text("\(size.name)")
                                        .modifier(Fonts(fontName: .outfit_bold,
                                                        colorName: .purple,
                                                        size: customSize.textField))
                                )
                        }

                        
                        Text(size.description)
                            .modifier(Fonts(fontName: .outfit_regular,
                                            colorName: .black,
                                            size: 14))
                            .padding(.leading)
                            
                    }
                }
                
                Spacer()
                
            }
            .padding(.leading)
            
            Text("Available Color:")
                .modifier(Fonts(fontName: .outfit_regular,
                                colorName: .black,
                                size: 20))
                .padding(.top)
                .padding(.leading)
            
            ScrollView(.horizontal,showsIndicators: false){
                HStack{

                        ForEach(product.color){ color in
                            
                            Button {
                                self.chooseColor = color._id
                            } label: {
                                RoundedRectangle(cornerRadius: 2)
                                    .stroke(lineWidth: 1)
                                    .frame(width: 100, height: 30)
                                    .foregroundColor(Color(self.chooseColor == color._id ? ColorsName.red.rawValue : ColorsName.purple.rawValue))
                                    .overlay(
                                        Text(color.name)
                                            .modifier(Fonts(fontName: .outfit_regular,
                                                            colorName: .purple,
                                                            size: customSize.textField))
                                    )
                            }


                            
                        }
                }

            }
                .padding(.leading)
                .padding(.top)
            
            HStack{
                Text("Quantity:")
                    .modifier(Fonts(fontName: .outfit_regular,
                                    colorName: .black,
                                    size: 20))
                Text(self.isChoose ? "\(vm.productDetail.number.filter{$0.size == self.chooseSize && $0.color == self.chooseColor}.first?.number ?? 0)" : "")
                    .frame(width: 45)
                    .modifier(Fonts(fontName: .outfit_regular,
                                    colorName: .black,
                                    size: 20))
            }
                .padding(.leading)
                .padding(.top)
            
            HStack{
                Button {
                    //MARK: DISTRUBRB
                    if self.quantity > 0 {
                        self.quantity -= 1
                    }
                } label: {
                    Image("Cart.distrurb")
                        .resizable()
                        .frame(width:customSize.buttonCartSize,
                               height:customSize.buttonCartSize)
                }

                Text("\(self.quantity)")
                    .modifier(Fonts(fontName: .outfit_regular,
                                    colorName: .black,
                                    size: customSize.textButton))
                    .frame(width: 28)
                    .padding(8)
                Button {
                    //MARK: PLUS
                    if self.quantity < vm.productDetail.number.filter({$0.size == self.chooseSize && $0.color == self.chooseColor}).first?.number ?? 0 {
                        self.quantity += 1
                    }
                } label: {
                    Image("Cart.plus")
                        .resizable()
                        .frame(width:customSize.buttonCartSize,
                               height:customSize.buttonCartSize)
                }


            }
            .padding(.leading)
            
            Spacer()
            
            
        }
        .background(Color(ColorsName.white.rawValue))
    }
    
    
    var addToCart: some View {
        VStack(alignment: .leading){
            HStack{
                VStack(alignment: .leading){
                    Text("Total Price")
                        .modifier(Fonts(fontName: .outfit_bold,
                                        colorName: .black,
                                        size: 24))
                    Text("\(product.price * quantity )đ")
                        .modifier(Fonts(fontName: .outfit_light,
                                        colorName: .red,
                                        size: 20))
                }
                .padding(.leading,2)
                
                Spacer()
                
                Button {
                    
                    Task{
                        do{
                            withAnimation(.easeInOut(duration:0.7)){
                                vm.startAnimation.toggle()
                            }
                            
                            try await vmCart.addtoCart(id_product: product._id, size: chooseSize, color: chooseColor, number: quantity)
                        }
                        catch{
                            
                        }
                    }
                    
                } label: {
                    VStack{
                        Text("Add to Cart")
                            .modifier(Fonts(fontName: .outfit_bold,
                                            colorName: .white,
                                            size: 20))
                    }
                    .frame(width:200,
                           height:customSize.heightButtonAdd)
                    .background(LinearGradient(colors: [Color(ColorsName.purple.rawValue),Color(ColorsName.blue.rawValue)], startPoint: .top, endPoint: .bottom))
                    .cornerRadius(10)
                }
                .disabled(self.quantity == 0 ? true : false)
                                
                
                
            }
            .padding()
        }
        .frame(height:90)
        .background(Color(ColorsName.white.rawValue))
        .cornerRadius(20)
        
    }
    
    func getRect() -> CGRect{
        return UIScreen.main.bounds
    }
    
    var review: some View {
        VStack{
            HStack{
                VStack(alignment: .leading,spacing:5){
                    Text("Product Review")
                        .modifier(Fonts(fontName: .outfit_regular,
                                        colorName: .black,
                                        size: 18))
                    HStack(spacing:5){
                        ForEach(1...Int(vm.productDetail.rate.rate == 0 ? 1: vm.productDetail.rate.rate ),id:\.self){ _ in
                            Image("Main.star")
                                .resizable()
                                .frame(width:16,height:16)
                        }
                        
                        Text("\(vm.productDetail.rate.rate)/5")
                            .modifier(Fonts(fontName: .outfit_bold,
                                            colorName: .listCategory,
                                            size: 14))
                            .padding(.leading,2)
                        Text("(\(vm.productDetail.rate.sum) reviews)")
                            .modifier(Fonts(fontName: .outfit_regular,
                                            colorName: .gray,
                                            size: 12))
                    }
                    
                }
                Spacer()
                
                HStack(spacing:4){
                    Text("View All")
                    Image(systemName: "chevron.right")
                }
                .modifier(Fonts(fontName: .outfit_regular,
                                colorName: .listCategory,
                                size: 16))
                 
            }
            .padding()
            Divider()
                .padding(.top,-12)
            VStack(alignment:.leading,spacing:5){
                Text("Image from Customer")
                    .modifier(Fonts(fontName: .outfit_regular,
                                    colorName: .black,
                                    size: 20))
                
                ScrollView(.horizontal){
                    HStack(spacing:8){
                        ForEach(vm.productDetail.comment){ comment in
                            ForEach(comment.urlImage,id:\.self){
                                url in
                                KFImage(URL(string: url))
                                    .resizable()
                                    .frame(width:120,height:120)
                            }
                            
                        }
                        .padding(.bottom)
                    }
                }
            }
            .padding(.leading)
            .padding(.trailing)
            Divider()
                .padding(.top,-12)
            
            VStack(alignment: .leading){
                ForEach(vm.productDetail.comment){ comment in
                    HStack(alignment: .top){
                        Image("test")
                            .resizable()
                            .frame(width:50,height:50)
                            .cornerRadius(50)
                        VStack(alignment:.leading,spacing:5){
                            Text(comment.id_account.name)
                                .modifier(Fonts(fontName: .outfit_regular,
                                                colorName: .black,
                                                size: 16))
                            HStack(spacing: 3){
                                ForEach(1...comment.star,id:\.self){ _ in
                                    Image("Main.star")
                                        .resizable()
                                        .frame(width:14,height:14)
                                }
                            }
                            
                            Text(comment.content)
                                .modifier(Fonts(fontName: .outfit_regular,
                                                colorName: .black,
                                                size: 18))
                            ScrollView(.horizontal){
                                HStack(spacing:8){
                                    ForEach(comment.urlImage,id: \.self){ url in
                                        KFImage(URL(string: url))
                                            .resizable()
                                            .frame(width:120,height:120)
                                        
                                    }
                                    .padding(.bottom)
                                }
                            }
                            
                        }
                        Spacer()
                    }
                    Divider()
                        .padding(.top,-12)
                }
                
                
                
            }
            .padding(.leading)
            .padding(.trailing)
            
        }
        .background(Color(ColorsName.white.rawValue))
        

    }
}


struct CardView: View {
    @Binding var currentAmount: CGFloat
    var urlImage: String
    var body: some View{
        VStack(alignment: .leading,spacing: 0) {
            KFImage(URL(string: urlImage))
                .resizable()
                .frame(width: UIScreen.main.bounds.width - 80, height: 300)
                

            
        }
        .scaleEffect(1 + currentAmount)
        .gesture(MagnificationGesture()
            .onChanged({ value in
                currentAmount = value - 1
            })
                .onEnded({ value in
                    withAnimation(.spring()){
                        currentAmount = 0
                    }
                })
        
        )


        .cornerRadius(25)
    }
}
