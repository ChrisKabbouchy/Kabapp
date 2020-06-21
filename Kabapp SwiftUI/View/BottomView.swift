//
//  BottomView.swift
//  Kabapp SwiftUI
//
//  Created by Christian Kabouchy on 6/21/20.
//  Copyright © 2020 Christian Kabouchy. All rights reserved.
//

import SwiftUI

struct bottomView: View {
    @EnvironmentObject var restaurantManager : RestaurantManager
    var body: some View {
        HStack{
            Spacer()
            Button(action: {
                let currentRest = self.restaurantManager.currentRest-1
                if  currentRest < self.restaurantManager.maxRestNumber-1 {
                    self.restaurantManager.restaurants[currentRest+1].offset = .zero
                    self.restaurantManager.restaurants[currentRest+1].isLiked = false
                    self.restaurantManager.currentRest += 1
                }
            }) {
                Image(systemName: "arrowshape.turn.up.right.circle.fill")
                    .resizable()
                    .frame(width: 45, height: 45)
                    .foregroundColor(.yellow)
                    .aspectRatio(contentMode: .fit)
            }
            Spacer()
            Button(action: {
                let currentRest = self.restaurantManager.currentRest-1
                if currentRest >= 0 {
                    self.restaurantManager.restaurants[currentRest].offset = .init(width: -1000, height: 0)
                    self.restaurantManager.restaurants[currentRest].isLiked = false
                    self.restaurantManager.currentRest -= 1
                }
            }) {
                Image(systemName: "multiply.circle.fill")
                    .resizable()
                    .frame(width: 45, height: 45)
                    .foregroundColor(.red)
                    .aspectRatio(contentMode: .fit)
            }
            Spacer()
            Button(action: {
                let currentRest = self.restaurantManager.currentRest-1
                if currentRest >= 0{
                    self.restaurantManager.restaurants[currentRest].offset = .init(width: 1000, height: 0)
                    self.restaurantManager.restaurants[currentRest].isLiked = true
                    self.restaurantManager.currentRest -= 1
                }
            }) {
                Image(systemName: "heart.fill")
                    .resizable()
                    .frame(width: 45, height: 45)
                    .foregroundColor(.red)
                    .aspectRatio(contentMode: .fit)
            }
            Spacer()
        }.padding()
    }
}
struct BottomView_Previews: PreviewProvider {
    static var previews: some View {
        bottomView()
    }
}
