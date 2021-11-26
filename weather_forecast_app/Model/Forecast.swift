//
//  Forecast.swift
//  weather_forecast_app
//
//  Created by José Alves da Cunha on 20/11/21.
//

import Foundation

struct Forecast: Codable {
    
    var weatherList: [Weather]
    
    private enum CodingKeys: String, CodingKey {
        case weatherList = "list"
    }
    
}
