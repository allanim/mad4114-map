//
//  Store.swift
//  mad4114-map
//
//  Created by Allan Im on 2018-12-08.
//  Copyright © 2018 Allan Im. All rights reserved.
//

import Foundation

struct Store {
    static var countries: [Country] = []
    
    static func initData() {
    
        countries.append(Country(name: "Korea", capital: "Seoul", latitude: 37.565289, longitude: 126.8491243))
        countries.append(Country(name: "China", capital: "Beijing", latitude: 39.9390715, longitude: 116.1165949))
        countries.append(Country(name: "Japan", capital: "Tokyo", latitude: 35.6735404, longitude: 139.5699621))
        countries.append(Country(name: "Taiwan", capital: "Taipei", latitude: 25.0174716, longitude: 121.3659514))
    }
}
