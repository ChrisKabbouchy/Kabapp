//
//  TopView.swift
//  Kabapp SwiftUI
//
//  Created by Christian Kabouchy on 6/21/20.
//  Copyright © 2020 Christian Kabouchy. All rights reserved.
//

import SwiftUI

struct topView: View {
    @EnvironmentObject var restaurantManager : RestaurantManager
    @EnvironmentObject var locationManager : LocationManager
    @State var isPressed =  false
    var body: some View {
        HStack{
            Button(action: {
                self.isPressed.toggle()
            }) {
                Image(systemName: "suit.heart")
                    .resizable()
                    .frame(width: 45, height: 45)
                    .foregroundColor(.gray)
                    .aspectRatio(contentMode: .fit)
            }.sheet(isPresented: $isPressed){
                LikedRestaurantView().environmentObject(self.restaurantManager)
            }.navigationBarItems(leading: Text("hello"))
            Spacer()
            Button(action: {
                self.restaurantManager.fetchData(location: self.locationManager.location)
            }) {
                Image(systemName: "flame.fill")
                    .resizable()
                    .frame(width: 50, height: 50)
                    .foregroundColor(.red)
                    .aspectRatio(contentMode: .fit)
            }
            Spacer()
            Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/) {
                Image(systemName: "gear")
                    .resizable()
                    .frame(width: 45, height: 45)
                    .foregroundColor(.gray)
                    .aspectRatio(contentMode: .fit)
            }
            
            
        }.padding()
    }
}

struct TopView_Previews: PreviewProvider {
    static var previews: some View {
        topView()
    }
}
