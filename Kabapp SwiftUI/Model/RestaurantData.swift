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

struct Restaurant : Decodable,Identifiable{
    let id = UUID()
    var restaurant : RestaurantDetails
    
}

struct RestaurantDetails : Decodable {
    
    var id : String
    var name :  String
    var url :  String
    var thumb :  String
    var location : location
    var cuisines : String
    var average_cost_for_two : Int
    var currency : String
    var user_rating : userRating
    var photos_url : String
    var menu_url : String
}

struct location : Decodable {
    var address : String
    var city : String
}
struct userRating : Decodable {
    var aggregate_rating : String
}
struct ImageData {
    var image : String?
}

