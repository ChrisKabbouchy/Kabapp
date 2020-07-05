//
//  RestaurantModel.swift
//  Kabapp SwiftUI
//
//  Created by Christian Kabouchy on 1/22/20.
//  Copyright © 2020 Christian Kabouchy. All rights reserved.
//

import Foundation
import SwiftUI

struct RestaurantModel : Identifiable {
    
    var id : Int
    var restaurant : RestaurantDetails
    var image : UIImage?
    var degree : Double
    var swipe : CGFloat
    var offset : CGSize
    var isLiked : Bool
    
    
    init() {
        id = 0
        degree = 0
        swipe = 0
        offset = .zero
        isLiked = false
        restaurant = RestaurantDetails(id: "", name: "", url: "", thumb: "", location: location(address: "", city: ""), cuisines: "", average_cost_for_two: 0, currency: "", user_rating: userRating(aggregate_rating: ""), photos_url : "", menu_url: "")
    }
}

