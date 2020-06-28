//
//  LikedRestaurantView.swift
//  Kabapp SwiftUI
//
//  Created by Christian Kabouchy on 6/21/20.
//  Copyright © 2020 Christian Kabouchy. All rights reserved.
//

import SwiftUI

struct LikedRestaurantView: View {
    @EnvironmentObject var restaurantManager : RestaurantManager
    var body: some View {
        VStack (alignment: .leading, spacing: 20){
            NavigationView{
                ScrollView{
                    ForEach(self.restaurantManager.restaurants){ restaurant in
                        if restaurant.isLiked {
                            NavigationLink(destination: DetailsRestaurantView(restaurantID: restaurant.id)){
                                    VStack(alignment:.leading){
                                        Image(uiImage: restaurant.image!)
                                            .resizable().frame(width: UIScreen.main.bounds.width - 40, height: UIScreen.main.bounds.height / 4)
                                        Text(restaurant.restaurant.name)
                                            .foregroundColor(Color("Color"))
                                            .font(.headline)
                                            .fontWeight(.heavy)
                                            .padding(.leading)
                                            .frame(height: 50,alignment: .leading)
                                    }.background(Color("reverseColor"))
                                        .cornerRadius(20)
                                        .padding(.vertical)
                            }.buttonStyle(PlainButtonStyle())
                        }
                    }
                    
                    Spacer()
                }.navigationBarTitle("Liked Restaurants")
            }
        }
        
    }
}

struct LikedRestaurantView_Previews: PreviewProvider {
    static var previews: some View {
        LikedRestaurantView()
    }
}
