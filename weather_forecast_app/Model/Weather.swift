//
//  Weather.swift
//  weather_forecast_app
//
//  Created by José Alves da Cunha on 20/11/21.
//

import Foundation

struct Weather: Codable {
    
    struct Coordinates: Codable {
        var longitude: Double
        var latitude: Double
        
        private enum CodingKeys: String, CodingKey {
            case longitude = "lon"
            case latitude = "lat"
        }
    }
    
    struct WeatherMain: Codable {
        
        var temp: Double
        var feelsLike: Double
        var tempMin: Double
        var tempMax: Double
        var humidity: Double
        
        private enum CodingKeys: String, CodingKey {
            
            case temp
            case feelsLike = "feels_like"
            case tempMin = "temp_min"
            case tempMax = "temp_max"
            case humidity
            
        }
        
    }
    
    struct WeatherDescription: Codable {
        
        var main: String
        var description: String
        var icon: String
        
    }
    
    var coordinates: Coordinates?
    var weatherMain: WeatherMain
    var weatherDescriptions: [WeatherDescription]
    var date: String?
    
    private enum CodingKeys: String, CodingKey {
        case coordinates = "coord"
        case weatherMain = "main"
        case weatherDescriptions = "weather"
        case date = "dt_txt"
    }
  
    
}
