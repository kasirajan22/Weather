//
//  LocationViewModel.swift
//  Weather
//
//  Created by Magizhan on 17/10/20.
//

import SwiftUI
import Combine
import CoreLocation

//class LocationViewModel: NSObject, ObservableObject{
//    //@ObservedObject var weatherManager = WeatherManager.shared
//    @ObservedObject var weatherManager = WeatherManager()
//    private let locationManager = CLLocationManager()
//    
//    override init() {
//        super.init()
//        self.locationManager.delegate = self
//        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
//        self.locationManager.requestWhenInUseAuthorization()
//        self.locationManager.startUpdatingLocation()
//    }
//    
//    func startUpdating() {
//        self.locationManager.requestLocation()
//    }
//    
//}
//
//extension LocationViewModel: CLLocationManagerDelegate {
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        if let location = locations.last {
//            locationManager.stopUpdatingLocation()
//            let lat = location.coordinate.latitude
//            let long = location.coordinate.longitude
//            weatherManager.fetchWeatherByCoordinates(latitude: lat, longitude: long)
//            print(lat)
//        }
//    }
//    
//    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
//        print(error)
//    }
//}
