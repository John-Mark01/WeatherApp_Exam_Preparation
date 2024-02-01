//
//  WeatherData.swift
//  WeatherApp_Exam_Preparation
//
//  Created by John-Mark Iliev on 1.02.24.
//

import Foundation


struct WeatherData: Decodable {
    
    let name: String
    let temp: Double
    let weatherArray: [Weather]
}

struct Weather: Decodable {
    let description: String
    let id: Int
}
