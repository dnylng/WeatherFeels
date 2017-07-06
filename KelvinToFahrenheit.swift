//
//  KelvinToFarenheit.swift
//  WeatherFeels
//
//  Created by Danny Luong on 7/6/17.
//  Copyright © 2017 dnylng. All rights reserved.
//

import Foundation

func kelvinToFahrenheit(_ temp: Double) -> Double {
    return Double(round(10 * ((temp) * (9/5) - 459.67)/10))
}
