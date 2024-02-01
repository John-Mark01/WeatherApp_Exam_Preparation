//
//  NetworkManager.swift
//  WeatherApp_Exam_Preparation
//
//  Created by John-Mark Iliev on 1.02.24.
//

import Foundation

struct NetworkManager {
    
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?&appid=fca2cd5933142256e59d27086ecc9d29&units=metric"
    
    func fetchWeather(cityName: String) {
        let urlString = "\(weatherURL)&q=\(cityName)"
      
    }
    
    
    
}
