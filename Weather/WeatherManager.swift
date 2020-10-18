//
//  WeatherManager.swift
//  Weather
//
//  Created by Magizhan on 17/10/20.
//

import SwiftUI
import Combine
import CoreLocation

class WeatherManager: NSObject, ObservableObject{
    @Published var image: String = "sun.max"
    @Published var cityName: String = ""
    @Published var temprature: String = ""
    @Published var errorMsg: String = ""
    @Published var showError: Bool = false
    private let locationManager = CLLocationManager()
    
    override init() {
        super.init()
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
        self.image = "sun.max"
        self.cityName = "Londan"
        self.temprature = "27"
        self.errorMsg = ""
        self.showError = false
    }
    
    public static var shared = WeatherManager()
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=035621abb24b609357a38e5941e98661&units=metric"
    
    func startUpdating() {
            self.locationManager.requestLocation()
        }
    func fetchWeather(cityName: String){
        let urlString = "\(weatherURL)&q=\(cityName)"
        performRequest(with: urlString)
    }
    
    func fetchWeatherByCoordinates(latitude: CLLocationDegrees, longitude: CLLocationDegrees){
        let urlString = "\(weatherURL)&lat=\(latitude)&lon=\(longitude)"
        performRequest(with: urlString)
    }
    
    func performRequest(with urlString: String) {
        if let url = URL(string: urlString) {
            
            let session = URLSession(configuration: .default)
            
            let task = session.dataTask(with: url) {(data,response,error) in
                if error != nil {
                    DispatchQueue.main.async {
                        self.errorMsg = error?.localizedDescription ?? ""
                        self.showError = true
                    }
                    return
                }
                if let safeData = data {
                    //let dataString = String(bytes: safeData, encoding: .utf8)
                    if let weather = self.parseJSON(safeData) {
                        DispatchQueue.main.async {
                            self.cityName = weather.cityName
                            self.image = weather.conditionName
                            self.temprature = weather.tempratureString
                        }
                    }
                }
            }
            task.resume()
        }
    }
    
    func parseJSON(_ weatherData: Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        
        do{
            let decodeData = try decoder.decode(WeatherData.self, from: weatherData)
            let weather = WeatherModel(conditionId: decodeData.weather[0].id, cityName: decodeData.name, temprature: decodeData.main.temp)
            return weather
        }
        catch{
            self.errorMsg = error.localizedDescription
            self.showError = true
            return nil
        }
    }
}

extension WeatherManager: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            locationManager.stopUpdatingLocation()
            let lat = location.coordinate.latitude
            let long = location.coordinate.longitude
            self.fetchWeatherByCoordinates(latitude: lat, longitude: long)
            print(lat)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}
