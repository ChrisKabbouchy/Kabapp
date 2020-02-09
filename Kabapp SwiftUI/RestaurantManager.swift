//
//  RestaurantManager.swift
//  Kabapp SwiftUI
//
//  Created by Christian Kabouchy on 1/5/20.
//  Copyright © 2020 Christian Kabouchy. All rights reserved.
//

import Foundation
import CoreLocation
import SwiftUI


class RestaurantManager: ObservableObject {
    
    
    @EnvironmentObject var locationManager : LocationManager
    @Published var restaurants = [Resto]()
    
    func updateUI(id : Int , offsetValue : CGSize)  {
        for i in 0..<restaurants.count {
            if restaurants[i].id == id{
                restaurants[i].offset = offsetValue
            }
        }
    }
    func fetchData(location : CLLocation?)  {
        let baseUrl = "https://developers.zomato.com/api/v2.1/geocode?"
        if let safeLocation = location{
            let finalUrl = "\(baseUrl)lat=\(safeLocation.coordinate.latitude)&lon=\(safeLocation.coordinate.longitude)"
            fetchData(url: finalUrl)
        }
        print("i am here")
    }
    func fetchData(url : String) {
        
        //let baseUrl = "https://developers.zomato.com/api/v2.1/geocode?lat=33.8333&lon=35.8333"
        let baseUrl = url
        let apiKey = "79010e4bdff8688f68fbeb86ee8c6345"
        
        
        let url = URL(string: baseUrl)
        
        var request = URLRequest(url: url!)
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue(apiKey, forHTTPHeaderField: "user-key")
        request.httpMethod = "GET"
        
        let session = URLSession(configuration: .default)
        
        let task = session.dataTask(with: request) { (data, response, error) in
            if error != nil{
                return
            }
            if let safeData = data{
                let decoder = JSONDecoder()
                do{
                    let decodedData = try decoder.decode(RestaurantData.self, from: safeData)
                    print(decodedData.nearby_restaurants[4].restaurant.name)
                        DispatchQueue.main.async {
                            for i in 0..<decodedData.nearby_restaurants.count{
                                var newRest = Resto()
                                newRest.restaurant = decodedData.nearby_restaurants[i].restaurant
                                newRest.id = i
                                self.restaurants.append(newRest)
                            }
                        }
                        
                }catch{
                    print(error)
                }
            }
        }
        task.resume()
    }
}
