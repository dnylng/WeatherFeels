//
//  CurrentWeather.swift
//  WeatherFeels
//
//  Created by Danny Luong on 7/3/17.
//  Copyright © 2017 dnylng. All rights reserved.
//

import Foundation
import Alamofire

// Current weather object w/ encapsulated vars
class CurrentWeather {
    
    private var _cityName: String!
    private var _date: String!
    private var _weatherType: String!
    private var _currentTemp: Double!
    
    var cityName: String {
        if _cityName == nil {
            _cityName = ""
        }
        return _cityName
    }
    
    var date: String {
        if _date == nil {
            _date = ""
        }
        
        // Format the date from the current date
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .none
        let currentDate = dateFormatter.string(from: Date())
        self._date = "Today, \(currentDate)"
        
        return _date
    }
    
    var weatherType: String {
        if _weatherType == nil {
            _weatherType = ""
        }
        return _weatherType
    }
    
    // When accessed, it'll be a string instead of double.
    var currentTemp: String {
        if _currentTemp == nil {
            _currentTemp = 0.0
        }
        return String(format: "%.1f°", _currentTemp)
    }
    
    func downloadWeatherDetails(completed: @escaping DownloadComplete) {
        // Alamofire download
        let currentWeatherURL = URL(string: CURRENT_WEATHER_URL)!
        Alamofire.request(currentWeatherURL).responseJSON {
            response in
            let result = response.result
            
            // The large/original dictionary
            if let dict = result.value as? Dictionary<String, AnyObject> {
                
                // Grab the key, "name", in the dictionary
                if let name = dict["name"] as? String {
                    self._cityName = name.capitalized
                    print("City Name: \(self._cityName!)")
                }
                
                // Grab weather, which is an array of dictionaries
                if let weather = dict["weather"] as? [Dictionary<String, AnyObject>] {
                    if let main = weather[0]["main"] as? String {
                        self._weatherType = main.capitalized
                        print("Weather Type: \(self._weatherType!)")
                    }
                }
                
                // Grab the key, "main", in the dictionary
                if let main = dict["main"] as? Dictionary<String, AnyObject> {
                    if let currentTemp = main["temp"] as? Double {
                        
                        // Convert from kelvins to farenheit
                        let kelvinToFarenheit = Double(round(10 * ((currentTemp) * (9/5) - 459.67)/10))
                        self._currentTemp = kelvinToFarenheit
                        print("Current Temp: \(self._currentTemp!)°")
                    }
                }
            }
//            print("Response: ")
//            print(response)
            completed()
        }
    }
    
}
