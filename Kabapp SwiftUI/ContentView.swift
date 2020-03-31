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


struct swipeView : View {
    @EnvironmentObject var restaurantManager : RestaurantManager
    @State private var offset: CGSize = .zero
    var body: some View {
        
        GeometryReader{ geo in
            ZStack{
                ForEach(self.restaurantManager.restaurants){ restaurant in
                    
//                    if (self.restaurantManager.restaurants.count-2 )...self.restaurantManager.restaurants.count ~= restaurant.id {
                        ZStack(alignment: .bottomLeading){
                            //imageView(currentRest: restaurant).environmentObject(self.restaurantManager)
                            imageView2(withURL: restaurant.restaurant.thumb, currentRest: self.restaurantManager.restaurants[restaurant.id])
                            labelView(currentRest: restaurant).environmentObject(self.restaurantManager)
                        }.offset(x: restaurant.offset.width, y: restaurant.offset.height)
                            //.rotationEffect(.degrees(Double(offset.width/geo.size.width)*25),anchor: .bottom)
                            .gesture(DragGesture()
                                .onChanged ({value in
                                    //self.offset = value.translation
                                    self.restaurantManager.restaurants[restaurant.id].offset = value.translation
                                    
                                })
                                .onEnded { value in
                                    if value.translation.width < -100 {
                                        //self.offset = .init(width: -1000, height: 0)
                                        self.restaurantManager.restaurants[restaurant.id].offset = .init(width: -1000, height: 0)
                                        //self.restaurantManager.restaurants.remove(at: restaurant.id)
                                        // self.restaurantManager.updateUI(id: restaurant.id, offsetValue: .init(width: -1000, height: 0))
//                                        Timer.scheduledTimer(withTimeInterval: 0.9, repeats: false) { (Timer) in
//                                            self.restaurantManager.restaurants.remove(at: restaurant.id)
//                                        }
                                        
                                    } else if value.translation.width > 100 {
                                        //self.offset = .init(width: 1000, height: 0)
                                        self.restaurantManager.restaurants[restaurant.id].offset = .init(width: 1000, height: 0)
                                        //self.restaurantManager.restaurants.remove(at: restaurant.id)
                                        // self.restaurantManager.updateUI(id: restaurant.id, offsetValue: .init(width: 1000, height: 0))
//                                        Timer.scheduledTimer(withTimeInterval: 0.9, repeats: false) { (Timer) in
//                                            self.restaurantManager.restaurants.remove(at: restaurant.id)
//                                        }
                                        
                                    } else {
                                        //self.offset = .zero
                                        self.restaurantManager.restaurants[restaurant.id].offset = .zero
                                        //self.restaurantManager.updateUI(id: restaurant.id, offsetValue: .zero)
                                    }
                            })
                            .animation(.spring())
                    }}
            
        }
    }
    
}

struct topView: View {
    @EnvironmentObject var manager : RestaurantManager
    @EnvironmentObject var locationManager : LocationManager
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
            Button(action: {self.manager.fetchData(location: self.locationManager.location)}) {
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
    var currentRestaurant : RestaurantModel
    init(currentRest : RestaurantModel) {
        currentRestaurant = currentRest
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
struct imageView2: View {
    
    @ObservedObject var imageLoader : ImageLoader
    var currentRestaurant : RestaurantModel
    
    init(withURL url:String, currentRest : RestaurantModel) {
        imageLoader = ImageLoader(urlString:url)
        currentRestaurant = currentRest
    }
    
    var body: some View{
        
//        if imageLoader.dataIsValid == true && currentRestaurant.image == nil{
//             currentRestaurant.image = UIImage(data: imageLoader.data!)!
//        }
//
        return Image(uiImage: (imageLoader.dataIsValid ? UIImage(data: imageLoader.data!)! : UIImage(systemName: "photo.fill"))!)
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: 320, height: 450, alignment: .center)
            //.padding(.all)
            .edgesIgnoringSafeArea(.all)
    }
}

struct labelView: View {
    @EnvironmentObject var manager : RestaurantManager
    var currentRestaurant : RestaurantModel
    init(currentRest : RestaurantModel) {
        currentRestaurant = currentRest
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
