//
//  ContentView.swift
//  Kabapp SwiftUI
//
//  Created by Christian Kabouchy on 12/29/19.
//  Copyright © 2019 Christian Kabouchy. All rights reserved.
//
import Foundation
import SwiftUI
import CoreLocation
import Combine

var firstLoad : Bool = true

struct ContentView: View {
    
    @EnvironmentObject var restaurantManager : RestaurantManager
    @EnvironmentObject var locationManager : LocationManager
    @State private var currentRest : Int = 8
    var body: some View {
        if locationManager.location != nil && firstLoad {
            restaurantManager.fetchData(location: locationManager.location)
            firstLoad = false
        }
        return VStack{
            topView()
            Spacer()
            swipeView()
            Spacer()
            bottomView()
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


