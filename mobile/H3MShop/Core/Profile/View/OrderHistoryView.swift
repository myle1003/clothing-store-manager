//
//  OrderHistoryView.swift
//  H3MShop
//
//  Created by Lê Văn Huy on 28/10/2022.
//

import SwiftUI

struct OrderHistoryView: View {
    
    @Environment(\.presentationMode) var presentationMode
    var customSize = CustomSize()
    @State private var selectFiller: StatsFillerViewModel = .toCheck
    @Namespace var animation
    @StateObject var vm = OrderHistoryViewModel()
    var body: some View {
        VStack{
            
            header
            statsFiller
            
            ScrollView{
                VStack{
                    ForEach(vm.bills){ bill in
                        
                        OrderHistoryRow(bill: bill)

                        
                    }
                }
            }
            
            
            Spacer()
        }
        .navigationBarHidden(true)
        .background(Color(ColorsName.white.rawValue).opacity(0.05))

    }
}

struct OrderHistoryView_Previews: PreviewProvider {
    static var previews: some View {
        OrderHistoryView()
    }
}

extension OrderHistoryView{
    
    var header: some View {
        HStack{
            
            
            Button {
                //MARK: GO TO PROFILE
                presentationMode.wrappedValue.dismiss()
            } label: {
                Image("Main.back")
                    .resizable()
                    .frame(width: customSize.mainButtonDetail,
                           height: customSize.mainButtonDetail)
            }
            Spacer()
            
            Text("Order History")
                .modifier(Fonts(fontName: .outfit_regular,
                                colorName: .black,
                                size: customSize.heightButtonList))
                .offset(x:-28)
            Spacer()
            
            
        }
        .padding(.leading)
        .padding(.trailing)
    }
    
    var statsFiller: some View {
        ScrollView(.horizontal,showsIndicators: false){
            HStack{
                Spacer()
                ForEach(StatsFillerViewModel.allCases, id:\.rawValue){
                    item in
                    VStack{
                        Text(item.title.0)
                            .modifier(Fonts(fontName: .outfit_regular, colorName: .black, size: 16))
                            .frame(width:80)
                        if selectFiller.title.0 == item.title.0 {
                            Capsule()
                                .foregroundColor(Color.gray)
                                .frame(width:87,
                                       height:1)
                                .matchedGeometryEffect(id: "filler",
                                                       in: animation)
                        }
                        else{
                            Capsule()
                                .foregroundColor(Color(.clear))
                                .frame(width:87,height:1)
                        }
                    }
                    .onTapGesture {
                            Task{
                                do{
                                    self.selectFiller = item
                                    vm.type = item.title.1
                                    try await vm.fetchBill()
                                }
                                catch{
                                    
                                }
                            }
                    }

                    }
                Spacer()
                }
        }
        
    }
}
