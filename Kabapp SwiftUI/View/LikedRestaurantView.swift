//
//  LikedRestaurantView.swift
//  Kabapp SwiftUI
//
//  Created by Christian Kabouchy on 6/21/20.
//  Copyright © 2020 Christian Kabouchy. All rights reserved.
//

import SwiftUI

struct LikedRestaurantView: View {
    @EnvironmentObject var restaurantManager : RestaurantManager
    var body: some View {
        
        ForEach(self.restaurantManager.restaurants){ restaurant in
            if restaurant.isLiked {
                Text(restaurant.restaurant.name)
            }
        }
        
    }
}

struct LikedRestaurantView_Previews: PreviewProvider {
    static var previews: some View {
        LikedRestaurantView()
    }
}
