//
//  APIConnect.swift
//  weather_forecast_app
//
//  Created by José Alves da Cunha on 20/11/21.
//

import Foundation


class APIConnect {
    
    
    static let shared = APIConnect()
    private var BASE_URL_WEATHER = "https://api.openweathermap.org/data/2.5/weather"
    private var BASE_URL_FORECAST = "https://api.openweathermap.org/data/2.5/forecast"
    private var API_ID = "5dd4c71bf880f1d7f532eb120db437ef"
    
    func weatherRequest(params:[String: String], completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        
        var urlComponent = URLComponents(string: BASE_URL_WEATHER)
        let firstQueryItem = URLQueryItem(name: "lat", value: params["latitude"])
        let secondQueryItem = URLQueryItem(name: "lon", value: params["longitude"])
        let idQueryItem = URLQueryItem(name: "appid", value: API_ID)
        
        urlComponent?.queryItems = [firstQueryItem, secondQueryItem, idQueryItem]
        
        guard let url = urlComponent?.url else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if error != nil {
                print("error:", error?.localizedDescription as Any)
            } else {
                completion(data, response, error)
            }
        }.resume()
    }
    
    func forecastRequest(params:[String: String], completion: @escaping(Data?, URLResponse?, Error?) -> ()) {
        
        var urlComponent = URLComponents(string: BASE_URL_FORECAST)
        let firstQueryItem = URLQueryItem(name: "lat", value: params["latitude"])
        let secondQueryItem = URLQueryItem(name: "lon", value: params["longitude"])
        let idQueryItem = URLQueryItem(name: "appid", value: API_ID)
        
        urlComponent?.queryItems = [firstQueryItem, secondQueryItem, idQueryItem]
        
        guard let url = urlComponent?.url else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if error != nil {
                print("error:", error?.localizedDescription as Any)
            } else {
                completion(data, response, error)
            }
        }.resume()
    }
    
    
}
