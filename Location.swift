//
//  Location.swift
//  WeatherFeels
//
//  Created by Danny Luong on 7/6/17.
//  Copyright © 2017 dnylng. All rights reserved.
//

import Foundation
import CoreLocation

class Location {
    static var sharedIntance = Location()
    
    private init() {}
    
    var latitude: Double!
    var longitude: Double!
}
