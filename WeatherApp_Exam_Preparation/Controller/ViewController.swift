//
//  ViewController.swift
//  WeatherApp_Exam_Preparation
//
//  Created by John-Mark Iliev on 1.02.24.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var weatherPicture: UIImageView!
    @IBOutlet weak var tempretureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var conditionLabel: UILabel!
    
    var networkManager = NetworkManager()
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        
        networkManager.delegate = self
        cityTextField.delegate = self
        let (captain, engineer, doctor) = ("mal", "jdfakla", "Simon")
        print(engineer)
    }

  
}
//MARK: - TextFieldDelegates
extension ViewController: UITextFieldDelegate {
    
    @IBAction func searchButtonPressed(_ sender: UIButton) {
        
        cityTextField.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        cityTextField.endEditing(true)
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != "" {
            return true
        } else {
            cityTextField.placeholder = "Type a city name..."
            return false
        }
    }
    
   func textFieldDidEndEditing(_ textField: UITextField) {
        
        if let city = cityTextField.text {
            networkManager.fetchWeather(cityName: city)
        }
        cityTextField.text = ""
    }
    
}

//MARK: - Network and API Manager
extension ViewController: NetworkManagerDelegate {
    
    func didUpdateWeather(_ NetworkManager: NetworkManager, weather: WeatherModel) {
        DispatchQueue.main.async {
            self.tempretureLabel.text = weather.temperatureString
            self.cityLabel.text = weather.cityName
            self.weatherPicture.image = UIImage(systemName: weather.conditionName)
            self.conditionLabel.text = weather.description.uppercased()
            print(weather.description)
        }
    }
    
    func didFailWithError(error: Error) {
        print("ERROR  IN VIEW CONTROLLER - \(error)")
    }
    
}

extension ViewController: CLLocationManagerDelegate {
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            locationManager.stopUpdatingLocation()
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            networkManager.fetchWeather(latitude: lat, longitude: lon)
        }
        
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
}
    


