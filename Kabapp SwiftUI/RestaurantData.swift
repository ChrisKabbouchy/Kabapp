//
//  RestaurantData.swift
//  Kabapp SwiftUI
//
//  Created by Christian Kabouchy on 1/5/20.
//  Copyright © 2020 Christian Kabouchy. All rights reserved.
//


import Foundation


struct RestaurantData : Decodable{
    var nearby_restaurants : [Restaurant]
}

struct Restaurant : Decodable{
    var restaurant : RestaurantDetails
}

struct RestaurantDetails : Decodable {
    
    var id : String
    var name :  String
    var url :  String
    var thumb :  String
}

struct ImageData {
    var image : String?
}

