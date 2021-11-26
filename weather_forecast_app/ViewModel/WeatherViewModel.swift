//
//  WeatherViewModel.swift
//  weather_forecast_app
//
//  Created by José Alves da Cunha on 20/11/21.
//

import Foundation
import CoreLocation

class WeatherViewModel {
    
    var currentWeather: Weather?
    
    func refreshWeather(params: [String: String],completion: @escaping () -> ()) {
        
        currentWeather = nil
        getWeather(params: params) { (weather) in
            
            self.currentWeather = weather
            completion()
        }
    }
    func getWeather(params:[String:String], completion:@escaping (Weather?) -> () ) {
        
        APIConnect.shared.weatherRequest(params: params) { (data, response, error) in
            
            
            guard let data = data else {return}
            
            if error != nil {
                completion(nil)
            }
            
            else {
                do {
                    
                    let weather = try JSONDecoder().decode(Weather.self, from: data)
                    completion(weather)
                } catch {
                    print("Error parsing weather JSON: ",error.localizedDescription)
                    completion(nil)
                }
            }
        }
    }
    
    func getCurrentTempInCelsius() -> Double? {
        
        guard let currentWeather = currentWeather else { return nil }
        return (currentWeather.weatherMain.temp - 273)
        
    }
    
    func getMinTempInCelsius() -> Double? {
        
        guard let currentWeather = currentWeather else { return nil }
        return (currentWeather.weatherMain.tempMin - 273)
        
    }
    
    func getMaxTempInCelsius() -> Double? {
           
           guard let currentWeather = currentWeather else { return nil }
           return (currentWeather.weatherMain.tempMax - 273)
    
    }
    
    func getWeatherDescription() -> String? {
        
        guard let currentWeather = currentWeather else { return nil }
        return currentWeather.weatherDescriptions.first?.description
        
    }
    
    func getWeatherIcon() -> String? {
        
        guard let currentWeather = currentWeather else { return nil }
        return currentWeather.weatherDescriptions.first?.icon
        
    }
    
    func getReverseGeoCode(completion: @escaping (CLPlacemark?) -> ())  {
        
        
        guard let currentWeather = currentWeather else {return}
        guard let coordinates = currentWeather.coordinates else {return}
        
        
        let location = CLLocation(latitude: coordinates.latitude, longitude: coordinates.longitude)
        
        CLGeocoder().reverseGeocodeLocation(location) { (placemarks, err) in
            
            guard let placemark = placemarks?.first else {return}
            completion(placemark)
            
        }
    }
    
}
