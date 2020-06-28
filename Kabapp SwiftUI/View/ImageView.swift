//
//  ImageView.swift
//  Kabapp SwiftUI
//
//  Created by Christian Kabouchy on 6/21/20.
//  Copyright © 2020 Christian Kabouchy. All rights reserved.
//

import SwiftUI

struct imageView: View {
    
    @ObservedObject var imageLoader : ImageLoader
    @EnvironmentObject var restaurantManager : RestaurantManager
    @State var currentImage : UIImage?
    var imageUrl : String
    var currentRest : RestaurantModel
    
    init(withURL url:String , currentRest:RestaurantModel ) {
        imageLoader = ImageLoader()
        imageUrl = url
        self.currentRest = currentRest
    }
    
    var body: some View{
        
        if currentImage == nil{
            imageLoader.loadImage(urlString: imageUrl)
        }
        
        if imageLoader.dataIsValid && currentImage == nil{
            DispatchQueue.main.async {
                self.currentImage = UIImage(data: self.imageLoader.data!)
                self.restaurantManager.restaurants[self.currentRest.id].image = self.currentImage
            }
            return Image(uiImage: UIImage(data: self.imageLoader.data!)!)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: UIScreen.main.bounds.width , height: UIScreen.main.bounds.height / 2, alignment: .center)
                .edgesIgnoringSafeArea(.all)
        }
        else if currentImage != nil {
            return Image(uiImage: currentImage!)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: UIScreen.main.bounds.width , height: UIScreen.main.bounds.height / 2, alignment: .center)
                .edgesIgnoringSafeArea(.all)
        }
        else{
            return Image(uiImage : UIImage(systemName: "photo.fill")!)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: UIScreen.main.bounds.width , height: UIScreen.main.bounds.height / 2, alignment: .center)
                .edgesIgnoringSafeArea(.all)
        }
        
    }
}

