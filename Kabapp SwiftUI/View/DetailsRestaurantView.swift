//
//  DetailsRestaurantView.swift
//  Kabapp SwiftUI
//
//  Created by Christian Kabouchy on 6/28/20.
//  Copyright © 2020 Christian Kabouchy. All rights reserved.
//

import SwiftUI

struct DetailsRestaurantView: View {
    @EnvironmentObject var restaurantManager : RestaurantManager
    var restaurantID : Int
    var body: some View {
        Text(restaurantManager.restaurants[restaurantID].restaurant.name)
    }
}

struct DetailsRestaurantView_Previews: PreviewProvider {
    static var previews: some View {
        DetailsRestaurantView(restaurantID: 1)
    }
}
