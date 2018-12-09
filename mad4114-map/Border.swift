//
//  Border.swift
//  mad4114-map
//
//  Created by Allan Im on 2018-12-08.
//  Copyright © 2018 Allan Im. All rights reserved.
//

import Foundation

struct Border {
    
    var sources: [Country]
    var dastinations: [Country]
    
    init() {
        sources = []
        dastinations = []
    }
    
    mutating func addSource(_ country: Country) {
        self.sources.append(country)
    }
    
    mutating func addDastination(_ country: Country) {
        self.dastinations.append(country)
    }
}
