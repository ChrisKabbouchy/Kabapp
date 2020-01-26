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
    @EnvironmentObject var restaurantManager : RestaurantManager
    var body: some View { 
        VStack{
            topView()
            Spacer()
            GeometryReader{ geo in
                    ZStack{
                        ForEach(self.restaurantManager.restaurants){ restaurant in
                            ZStack(alignment: .bottomLeading){
                                imageView(manager: restaurant)
                                labelView(manager: restaurant)
                                
                            }.gesture(DragGesture()
                                    .onChanged({ (value) in
                                        if value.translation.width > 0{
                                            self.restaurantManager.updateUI(id: restaurant.id, swipeValue: value.translation.width, degreeValue: 8)
//                                            restaurant.swipe =
//                                            restaurant.degree = 8
                                        }
                                        else{
                                            self.restaurantManager.updateUI(id: restaurant.id, swipeValue:  value.translation.width, degreeValue: -8)
//                                            restaurant.swipe  = value.translation.width
//                                            restaurant.degree = -8
                                        }
                                        
                                    }).onEnded({ (value) in
                                        if restaurant.swipe > 0{
                                            if restaurant.swipe  > geo.size.width / 2 {
                                                self.restaurantManager.updateUI(id: restaurant.id, swipeValue: 500, degreeValue: 0)
//                                                restaurant.swipe  = 500
//                                                restaurant.degree = 0
                                            }
                                            else{
                                                self.restaurantManager.updateUI(id: restaurant.id, swipeValue: 0, degreeValue: 0)
//                                                restaurant.swipe  = 0
//                                                restaurant.degree = 0
                                            }
                                        }
                                        else{
                                            if -restaurant.swipe > geo.size.width / 2 {
                                                self.restaurantManager.updateUI(id: restaurant.id, swipeValue: -500, degreeValue: 0)
//                                                restaurant.swipe  = -500
//                                                restaurant.degree = 0
                                            }
                                            else{
                                                self.restaurantManager.updateUI(id: restaurant.id, swipeValue: 0, degreeValue: 0)
//                                                restaurant.swipe  = 0
//                                                restaurant.degree = 0
                                            }
                                        }
                                    })).offset(x: restaurant.swipe )
                                    .rotationEffect(.init(degrees: restaurant.degree))
                                .animation(.interactiveSpring())
                                
                            }
                }
            }
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
    @EnvironmentObject var manager : RestaurantManager
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
    @EnvironmentObject var manager : RestaurantManager
    var currentRestaurant : Resto
    init(manager restaurantManager : Resto) {
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
    @EnvironmentObject var manager : RestaurantManager
    var currentRestaurant : Resto
    init(manager restaurantManager : Resto) {
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
