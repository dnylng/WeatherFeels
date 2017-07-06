//
//  Constants.swift
//  WeatherFeels
//
//  Created by Danny Luong on 7/3/17.
//  Copyright © 2017 dnylng. All rights reserved.
//

import Foundation

let API_KEY = "02d8e89554054400de86394424cf447d"

typealias DownloadComplete = () -> ()

let CURRENT_WEATHER_URL = "http://api.openweathermap.org/data/2.5/weather?lat=\(Location.sharedIntance.latitude!)&lon=\(Location.sharedIntance.longitude!)&appid=\(API_KEY)"
let FORECAST_URL = "http://api.openweathermap.org/data/2.5/forecast/daily?lat=\(Location.sharedIntance.latitude!)&lon=\(Location.sharedIntance.longitude!)&cnt=10&mode=json&appid=02d8e89554054400de86394424cf447d"
