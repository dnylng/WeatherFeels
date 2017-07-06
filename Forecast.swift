//
//  Forecast.swift
//  WeatherFeels
//
//  Created by Danny Luong on 7/6/17.
//  Copyright © 2017 dnylng. All rights reserved.
//

import Foundation
import Alamofire

class Forecast {
    
    private var _date: String!
    private var _weatherType: String!
    private var _highTemp: Double!
    private var _lowTemp: Double!
    
    var date: String {
        if _date == nil {
            _date = ""
        }
        return _date
    }
    
    var weatherType: String {
        if _weatherType == nil {
            _weatherType = ""
        }
        return _weatherType
    }
    
    var highTemp: String {
        if _highTemp == nil {
            _highTemp = 0.0
        }
        return String(format: "%.1f°", _highTemp)
    }
    
    var lowTemp: String {
        if _lowTemp == nil {
            _lowTemp = 0.0
        }
        return String(format: "%.1f°", _lowTemp)
    }
    
    init(weatherDict: Dictionary<String, AnyObject>) {
        
        // Access the temp dictionary
        if let temp = weatherDict["temp"] as? Dictionary<String, AnyObject> {
            
            // Grab the low temp from list dictionary
            if let min = temp["min"] as? Double {
                self._lowTemp = kelvinToFahrenheit(min)
            }
            
            // Grab the high temp from list dictionary
            if let max = temp["max"] as? Double {
                self._highTemp = kelvinToFahrenheit(max)
            }
        }
        
        // Access the weather array (of dictionaries)
        if let weather = weatherDict["weather"] as? [Dictionary<String, AnyObject>] {
            
            // Retrieve the main weather description
            if let main = weather[0]["main"] as? String {
                self._weatherType = main
            }
        }
        
        // Access the date, formatted as a UNIX timestamp
        if let date = weatherDict["dt"] as? Double {
            // Convert the date
            let unixConvertedDate = Date(timeIntervalSince1970: date)
            self._date = unixConvertedDate.dayOfTheWeek()
        }
    }
    
}

extension Date {
    func dayOfTheWeek() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: self)
    }
}
