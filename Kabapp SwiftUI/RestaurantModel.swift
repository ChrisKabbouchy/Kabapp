//
//  RestaurantModel.swift
//  Kabapp SwiftUI
//
//  Created by Christian Kabouchy on 1/22/20.
//  Copyright © 2020 Christian Kabouchy. All rights reserved.
//

import Foundation
import SwiftUI

struct Resto : Identifiable{
    var id : UUID
    var restaurant : RestaurantDetails
    var degree : Double = 0
    var swipe : CGFloat = 0
    
    init() {
        id = UUID()
        degree = 0
        swipe = 0
        restaurant = RestaurantDetails(id: "", name: "", url: "", thumb: "")
    }
}

