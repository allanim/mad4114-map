//
//  Country.swift
//  mad4114-map
//
//  Created by Allan Im on 2018-12-08.
//  Copyright © 2018 Allan Im. All rights reserved.
//

import Foundation

struct Country {
    var name: String
    var capital: String
    var latitude: Double
    var longitude: Double
    
    init(name: String, capital: String, latitude: Double, longitude: Double) {
        self.name = name
        self.capital = capital
        self.latitude = latitude
        self.longitude = longitude
    }
}
