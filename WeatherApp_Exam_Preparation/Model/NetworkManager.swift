//
//  NetworkManager.swift
//  WeatherApp_Exam_Preparation
//
//  Created by John-Mark Iliev on 1.02.24.
//

import Foundation
import CoreLocation

protocol NetworkManagerDelegate {
    func didUpdateWeather(_ NetworkManager: NetworkManager, weather: WeatherModel)
    func didFailWithError(error: Error)
}

struct NetworkManager {
    
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?&appid=fca2cd5933142256e59d27086ecc9d29&units=metric"
    
    var delegate: NetworkManagerDelegate?
    
    func fetchWeather(cityName: String) {
        let urlString = "\(weatherURL)&q=\(cityName)"
        performRequest(url: urlString)
        
    }
    
    func fetchWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        let urlString = "\(weatherURL)&lat=\(latitude)&lon=\(longitude)"
        self.performRequest(url: urlString)
        print(urlString)
    }
    
    func performRequest(url: String) {
        
        if let url = URL(string: url) {
            
            let session = URLSession(configuration: .default)
            
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                if let safeData = data {
                    if let weather = self.parseJSON(safeData) {
                        self.delegate?.didUpdateWeather(self, weather: weather)
                    }
                }
            }
            task.resume()
        }
        
    }
    
    func parseJSON(_ weatherData: Data) -> WeatherModel? {
         let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            let id = decodedData.weather[0].id
            let temp = decodedData.main.temp
            let name = decodedData.name
            
            let weather = WeatherModel(conditionId: id, cityName: name, temprature: temp)
            return weather
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
        
    }
}
