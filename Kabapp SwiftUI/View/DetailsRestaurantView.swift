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
        let restaurant = restaurantManager.restaurants[restaurantID]
        return VStack{
            ScrollView{
                VStack(alignment: .leading, spacing: 10){
                    Image(uiImage: restaurant.image ?? UIImage(systemName: "photo")!)
                        .resizable()
                        .edgesIgnoringSafeArea(.all)
                        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height / 2.5)
                    Text(restaurant.restaurant.name)
                        .font(.largeTitle)
                        .fontWeight(.heavy)
                        .padding(.horizontal)
                    Text("Address: \(restaurant.restaurant.location.address)")
                        .padding(.horizontal)
                        .font(.headline)
                    Text("Rating: \(restaurant.restaurant.user_rating.aggregate_rating) / 5")
                        .padding(.horizontal)
                        .font(.headline)
                    Text("Cuisines: \(restaurant.restaurant.cuisines)")
                        .padding(.horizontal)
                        .font(.headline)
                    Text("Average cost for two: \(restaurant.restaurant.average_cost_for_two) \(restaurant.restaurant.currency)")
                        .font(.headline)
                        .padding(.horizontal)
                    Spacer()
                }
            }
            Spacer()
            VStack(alignment: .center){
                Button(action:{
                    if let url = URL(string: restaurant.restaurant.menu_url){
                        UIApplication.shared.open(url)
                    }
                }){
                    Text("Menu")
                        .bold()
                        .padding(.horizontal)
                        .frame(width: UIScreen.main.bounds.width - 100,height: 50 ,alignment: .center)
                        .foregroundColor(Color.white)
                        .background(Color.red)
                        .cornerRadius(10)
                }
                Button(action:{
                    if let url = URL(string: restaurant.restaurant.photos_url){
                        UIApplication.shared.open(url)
                    }
                    
                }){
                    Text("Photos")
                        .bold()
                        .padding(.horizontal)
                        .frame(width: UIScreen.main.bounds.width - 100,height: 50 ,alignment: .center)
                        .foregroundColor(Color.white)
                        .background(Color.red)
                        .cornerRadius(10)
                }.padding()
            }
            Spacer()
        }.edgesIgnoringSafeArea(.all)
    }
}

struct DetailsRestaurantView_Previews: PreviewProvider {
    static var previews: some View {
        DetailsRestaurantView(restaurantID: 1)
    }
}
