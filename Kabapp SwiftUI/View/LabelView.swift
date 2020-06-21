//
//  LableView.swift
//  Kabapp SwiftUI
//
//  Created by Christian Kabouchy on 6/21/20.
//  Copyright © 2020 Christian Kabouchy. All rights reserved.
//

import SwiftUI

struct labelView: View {
    @EnvironmentObject var manager : RestaurantManager
    var currentRestaurant : RestaurantModel
    init(currentRest : RestaurantModel) {
        currentRestaurant = currentRest
    }
    var body: some View {
        VStack {
            Text(currentRestaurant.restaurant.name)
                .padding()
                .font(.title)
                .foregroundColor(.white)
        }
    }
}
