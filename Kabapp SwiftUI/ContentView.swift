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
    @State private var offset: CGSize = .zero
    var body: some View {
        
       return VStack{
            topView()
            Spacer()
            GeometryReader{ geo in
                    ZStack{
                        ForEach(self.restaurantManager.restaurants){ restaurant in
                            ZStack(alignment: .bottomLeading){
                                imageView(manager: restaurant)
                                labelView(manager: restaurant)
                                
                            }.offset(x: restaurant.offset.width, y: restaurant.offset.height)
                            .gesture(DragGesture()
                                .onChanged {value in self.offset = value.translation
                                    //self.restaurantManager.restaurants[restaurant.id].offset = value.translation
                            }
                                .onEnded { value in
                                    if value.translation.width < -100 {
                                        //self.offset = .init(width: -1000, height: 0)
                                        self.restaurantManager.restaurants[restaurant.id].offset = .init(width: -1000, height: 0)
                                        //self.restaurantManager.updateUI(id: restaurant.id, offsetValue: .init(width: -1000, height: 0))
                                    } else if value.translation.width > 100 {
                                        //self.offset = .init(width: 1000, height: 0)
                                        self.restaurantManager.restaurants[restaurant.id].offset = .init(width: 1000, height: 0)
                                        //self.restaurantManager.updateUI(id: restaurant.id, offsetValue: .init(width: 1000, height: 0))
                                    } else {
                                        //self.offset = .zero
                                        self.restaurantManager.restaurants[restaurant.id].offset = .zero
                                        //self.restaurantManager.updateUI(id: restaurant.id, offsetValue: .zero)
                                    }
                            })
                            .animation(.spring())
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
