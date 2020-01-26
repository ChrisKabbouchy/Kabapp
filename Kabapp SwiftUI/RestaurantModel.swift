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
    var id : Int
    var restaurant : RestaurantDetails
    var degree : Double = 0
    var swipe : CGFloat = 0
    var offset : CGSize = .zero
    
    init() {
        id = 0
        degree = 0
        swipe = 0
        restaurant = RestaurantDetails(id: "", name: "", url: "", thumb: "")
    }
}

