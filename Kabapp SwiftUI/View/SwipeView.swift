//
//  SwipeView.swift
//  Kabapp SwiftUI
//
//  Created by Christian Kabouchy on 6/21/20.
//  Copyright © 2020 Christian Kabouchy. All rights reserved.
//

import SwiftUI

struct swipeView : View {
    @EnvironmentObject var restaurantManager : RestaurantManager
    var body: some View {
        ZStack{
            ForEach(self.restaurantManager.restaurants){ restaurant in
                ZStack(alignment: .bottomLeading){
                    imageView(withURL: restaurant.restaurant.thumb, currentRest: self.restaurantManager.restaurants[restaurant.id])
                    labelView(currentRest: restaurant).environmentObject(self.restaurantManager)
                }.offset(x: restaurant.offset.width, y: restaurant.offset.height)
                    .gesture(DragGesture()
                        .onChanged ({value in
                            self.restaurantManager.restaurants[restaurant.id].offset = value.translation
                        })
                        .onEnded { value in
                            if value.translation.width < -100 {// is disliked
                                self.restaurantManager.restaurants[restaurant.id].offset = .init(width: -1000, height: 0)
                                self.restaurantManager.restaurants[restaurant.id].isLiked = false
                                self.restaurantManager.currentRest -= 1
                            } else if value.translation.width > 100 {// is liked
                                self.restaurantManager.restaurants[restaurant.id].offset = .init(width: 1000, height: 0)
                                self.restaurantManager.restaurants[restaurant.id].isLiked = true
                                self.restaurantManager.currentRest -= 1
                            } else {// failed to decide
                                self.restaurantManager.restaurants[restaurant.id].offset = .zero
                            }
                    })
                    .animation(.spring())
            }}
        
    }
    
}

struct SwipeView_Previews: PreviewProvider {
    static var previews: some View {
        swipeView()
    }
}
