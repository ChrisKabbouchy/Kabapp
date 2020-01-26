//
//  RestaurantManager.swift
//  Kabapp SwiftUI
//
//  Created by Christian Kabouchy on 1/5/20.
//  Copyright © 2020 Christian Kabouchy. All rights reserved.
//

import Foundation
import SwiftUI


class RestaurantManager: ObservableObject {
    
    
    @Published var imageData : UIImage?
    @Published var restaurants = [Resto()]

//    @Published var degree : Double = 0
//    @Published var swipe : CGFloat = 0

    func updateUI(id : UUID , swipeValue : CGFloat , degreeValue : Double)  {
        for i in 0..<restaurants.count {
            if restaurants[i].id == id{
                restaurants[i].swipe = swipeValue
                restaurants[i].degree = degreeValue
            }
        }
    }
    func fetchData() {
        
        let baseUrl = "https://developers.zomato.com/api/v2.1/geocode?lat=33.8333&lon=35.8333"
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
                    let imageString = decodedData.nearby_restaurants[4].restaurant.thumb
                    let imageUrl = URL(string: imageString)
                    let imageDataa = try? Data(contentsOf: imageUrl!)
                    if let safeImageData = imageDataa {
                        //self.delegate?.restaurantDidUpdate(imageData : safeImageData)
                        DispatchQueue.main.async {
                            self.imageData = UIImage(data: safeImageData)
                            for i in 0..<decodedData.nearby_restaurants.count{
                                var newRest = Resto()
                                newRest.restaurant = decodedData.nearby_restaurants[i].restaurant
                                if i == 0 {
                                    self.restaurants[i] = newRest
                                }else{
                                    self.restaurants.append(newRest)
                                }
                                //self.restaurants[i].restaurant = decodedData.nearby_restaurants[i].restaurant
                            }
                            //self.endRestaurant.restDaata = decodedData.nearby_restaurants
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
