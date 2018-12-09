//
//  Border.swift
//  mad4114-map
//
//  Created by Allan Im on 2018-12-08.
//  Copyright © 2018 Allan Im. All rights reserved.
//

import Foundation
import CoreLocation

struct Border {
    
    var contries: [Country]
    
    init() {
        contries = []
    }
    
    mutating func addCountry(_ country: Country) {
        self.contries.append(country)
    }
    
    func distance() -> [Distance] {
        var result: [Distance] = []
        let size = contries.count - 1
        for s in 0...size {
            if s < size {
                for d in (s+1)...size {
                    result.append(Distance(source: contries[s], destination:  contries[d]))
                }
            }
        }
        
        return result
    }
    
}

struct Distance {
    var source: Country
    var destination: Country
    var distance: Double
    
    init(source: Country, destination: Country) {
        self.source = source
        self.destination = destination
        self.distance = CLLocation(latitude: source.latitude, longitude: source.longitude).distance(from: CLLocation(latitude: destination.latitude, longitude: destination.longitude))
    }
    
    var description: String {
        return source.name + " to " + destination.name + " : " + String(distance)
    }
}
