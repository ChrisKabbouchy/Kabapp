//
//  ContentView.swift
//  Kabapp SwiftUI
//
//  Created by Christian Kabouchy on 12/29/19.
//  Copyright © 2019 Christian Kabouchy. All rights reserved.
//
import Foundation
import SwiftUI
import Combine

struct ContentView: View {
    @ObservedObject var restaurantManager = RestaurantManager()
    init() {
        restaurantManager.fetchData()
    }
    var body: some View {
        VStack{
            topView(manager: restaurantManager)
            Spacer()
            List(restaurantManager.restaurants){ restaurant in
                ZStack(alignment: .bottomLeading){
                    imageView(manager: restaurant)
                    labelView(manager: restaurant)
                    
                }
                
                }.frame(alignment: .center)
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

struct topView: View {
    @ObservedObject var manager : RestaurantManager
    var body: some View {
        HStack{
            Button(action: {
                print("hello")
                
            }) {
                Image(systemName: "square.and.pencil")
                    .resizable()
                    .frame(width: 45, height: 45)
                    .foregroundColor(.gray)
                    .aspectRatio(contentMode: .fit)
            }
            Spacer()
            Button(action: {self.manager.fetchData()}) {
                Image(systemName: "flame.fill")
                    .resizable()
                    .frame(width: 50, height: 50)
                    .foregroundColor(.red)
                    .aspectRatio(contentMode: .fit)
            }
            
            Spacer()
            Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/) {
                Image(systemName: "message.fill")
                    .resizable()
                    .frame(width: 45, height: 45)
                    .foregroundColor(.gray)
                    .aspectRatio(contentMode: .fit)
            }
            
            
        }.padding()
    }
}

struct bottomView: View {
    var body: some View {
        HStack{
            Spacer()
            Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/) {
                Image(systemName: "arrowshape.turn.up.right.circle.fill")
                    .resizable()
                    .frame(width: 45, height: 45)
                    .foregroundColor(.yellow)
                    .aspectRatio(contentMode: .fit)
            }
            Spacer()
            Button(action: {}) {
                Image(systemName: "multiply.circle.fill")
                    .resizable()
                    .frame(width: 45, height: 45)
                    .foregroundColor(.red)
                    .aspectRatio(contentMode: .fit)
            }
            Spacer()
            Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/) {
                Image(systemName: "star.fill")
                    .resizable()
                    .frame(width: 45, height: 45)
                    .foregroundColor(.blue)
                    .aspectRatio(contentMode: .fit)
            }
            Spacer()
            Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/) {
                Image(systemName: "heart.fill")
                    .resizable()
                    .frame(width: 45, height: 45)
                    .foregroundColor(.red)
                    .aspectRatio(contentMode: .fit)
            }
            Spacer()
        }.padding()
    }
}

struct imageView: View {
    @ObservedObject var manager = RestaurantManager()
    var currentRestaurant : Restaurant
    init(manager restaurantManager : Restaurant) {
        currentRestaurant = restaurantManager
    }
    var body: some View {
        let imageString = currentRestaurant.restaurant.thumb
        if let imageUrl = URL(string: imageString){
            let imageDataa = try? Data(contentsOf: imageUrl)
            if let safeImageData = imageDataa {
                let imageData = UIImage(data: safeImageData)
                return Image(uiImage: imageData!)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 320, height: 450, alignment: .center)
                    //.padding(.all)
                    .edgesIgnoringSafeArea(.all)
            }else{
                return Image("image")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 320, height: 450, alignment: .center)
                    //.padding(.all)
                    .edgesIgnoringSafeArea(.all)
            }
            
        }else{
            return Image("image")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 320, height: 450, alignment: .center)
                //.padding(.all)
                .edgesIgnoringSafeArea(.all)
        }
    }
}

struct labelView: View {
    @ObservedObject var manager = RestaurantManager()
    var currentRestaurant : Restaurant
    init(manager restaurantManager : Restaurant) {
        currentRestaurant = restaurantManager
    }
    var body: some View {
        VStack {
            Text(currentRestaurant.restaurant.name)
                .padding()
                .font(.title)
                .foregroundColor(.white)
        }
    }
}
