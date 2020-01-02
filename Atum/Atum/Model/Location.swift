//
//  Location.swift
//  Atum
//
//  Created by Wouter Willebrands on 02/01/2020.
//  Copyright © 2020 Studio Willebrands. All rights reserved.
//

import Foundation

struct Location {
    let locationName: String
    let latitude: String
    let longitude: String
    
    static let randomField1: Location = Location(locationName: "Field 1", latitude: "1.5", longitude: "100.75")
    static let randomField2: Location = Location(locationName: "Field 2", latitude: "2.5", longitude: "100.75")
    static let randomField3: Location = Location(locationName: "Field 3", latitude: "3.5", longitude: "100.75")
    static let randomField4: Location = Location(locationName: "Field 4", latitude: "4.5", longitude: "100.75")


}
