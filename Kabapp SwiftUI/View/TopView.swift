//
//  TopView.swift
//  Kabapp SwiftUI
//
//  Created by Christian Kabouchy on 6/21/20.
//  Copyright © 2020 Christian Kabouchy. All rights reserved.
//

import SwiftUI

struct topView: View {
    @EnvironmentObject var manager : RestaurantManager
    @EnvironmentObject var locationManager : LocationManager
    var body: some View {
        HStack{
            Button(action: {
                print("hello")
                
            }) {
                Image(systemName: "square.and.pencil")
                    .resizable()
                    .frame(width: 45, height: 45)
                    .foregroundColor(.gray)
                    .aspectRatio(contentMode: .fit)
            }
            Spacer()
            Button(action: {self.manager.fetchData(location: self.locationManager.location)}) {
                Image(systemName: "flame.fill")
                    .resizable()
                    .frame(width: 50, height: 50)
                    .foregroundColor(.red)
                    .aspectRatio(contentMode: .fit)
            }
            
            Spacer()
            Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/) {
                Image(systemName: "message.fill")
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
