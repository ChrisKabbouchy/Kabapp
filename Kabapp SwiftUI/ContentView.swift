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
    var body: some View {
        
        GeometryReader{ geo in
            ZStack{
                ForEach(self.restaurantManager.restaurants){ restaurant in
                    ZStack(alignment: .bottomLeading){
                        imageView(withURL: restaurant.restaurant.thumb)
                        labelView(currentRest: restaurant).environmentObject(self.restaurantManager)
                    }.offset(x: restaurant.offset.width, y: restaurant.offset.height)
                        .gesture(DragGesture()
                            .onChanged ({value in
                                self.restaurantManager.restaurants[restaurant.id].offset = value.translation
                            })
                            .onEnded { value in
                                if value.translation.width < -100 {
                                    self.restaurantManager.restaurants[restaurant.id].offset = .init(width: -1000, height: 0)
                                } else if value.translation.width > 100 {
                                    self.restaurantManager.restaurants[restaurant.id].offset = .init(width: 1000, height: 0)
                                } else {
                                    self.restaurantManager.restaurants[restaurant.id].offset = .zero
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
    
    @ObservedObject var imageLoader : ImageLoader
    @State var currentImage : UIImage?
    var imageUrl : String
    
    init(withURL url:String) {
        imageLoader = ImageLoader()
        imageUrl = url
    }
    
    var body: some View{
        
        if currentImage == nil{
            imageLoader.loadImage(urlString: imageUrl)
        }
        
        if imageLoader.dataIsValid && currentImage == nil{
            DispatchQueue.main.async {
                self.currentImage = UIImage(data: self.imageLoader.data!)
            }
            return Image(uiImage: UIImage(data: self.imageLoader.data!)!)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 320, height: 450, alignment: .center)
                .edgesIgnoringSafeArea(.all)
        }
        else if currentImage != nil {
            return Image(uiImage: currentImage!)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 320, height: 450, alignment: .center)
                .edgesIgnoringSafeArea(.all)
        }
        else{
            return Image(uiImage : UIImage(systemName: "photo.fill")!)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 320, height: 450, alignment: .center)
                .edgesIgnoringSafeArea(.all)
        }
        
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
