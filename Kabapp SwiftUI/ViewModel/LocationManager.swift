//
//  LocationManager.swift
//  Kabapp SwiftUI
//
//  Created by Christian Kabouchy on 2/8/20.
//  Copyright © 2020 Christian Kabouchy. All rights reserved.
//

import Foundation
import CoreLocation
import SwiftUI

class LocationManager: NSObject,ObservableObject{
    
    private let locationManager = CLLocationManager()
    @Published var location : CLLocation?
    
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
    }
}
extension LocationManager :  CLLocationManagerDelegate{
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            locationManager.stopUpdatingLocation()
            self.location = location
        }
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("error loading location \(error)")
    }
}
