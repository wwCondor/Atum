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
    
    static let mountEverest: Location       = Location(locationName: "Mount Everest",           latitude: "27.9881",    longitude: "86.9250")
    static let edinBurghCastle: Location    = Location(locationName: "Edinburgh Castle",        latitude: "55.953251",  longitude: "-3.188267")
    static let pyramidOfGiza: Location      = Location(locationName: "Great Pyramid of Giza",   latitude: "29.9792",    longitude: "31.1342")
    static let eiffelTower: Location        = Location(locationName: "Eiffel Tower",            latitude: "48.8584",    longitude: "2.2945")
    static let colosseum: Location          = Location(locationName: "Colloseum",               latitude: "41.8902",    longitude: "12.4922")
    
    static let christTheRedeemer: Location  = Location(locationName: "Christ the Redeemer",     latitude: "-22.9519",   longitude: "-43.2105")
    static let chichenItza: Location        = Location(locationName: "Chichen Itza",            latitude: "20.6843",    longitude: "-88.5678")
    static let machuPichu: Location         = Location(locationName: "Machu Pichu",             latitude: "-13.1631",   longitude: "-72.5450")
    static let towerOfPisa: Location        = Location(locationName: "Tower of Pisa",           latitude: "43.7230",    longitude: "10.3966")
    static let chineseWall: Location        = Location(locationName: "Chinese Wall",            latitude: "40.4319",    longitude: "116.5704")
    
    static let uluru: Location              = Location(locationName: "Uluru",                   latitude: "-25.3444",   longitude: "131.0369")
    static let grandCanyon: Location        = Location(locationName: "Grand Canyon",            latitude: "36.1070",    longitude: "-112.1130")
    static let paricutin: Location          = Location(locationName: "Paricutin",               latitude: "19.4933",    longitude: "-102.2514")
    static let oukaimeden: Location         = Location(locationName: "Oukaimeden",              latitude: "31.1948",    longitude: "-7.8551")
    static let northernLight: Location      = Location(locationName: "Northern Light",          latitude: "64.8378",    longitude: "-147.7164")
    
    static let victoriaFalls: Location      = Location(locationName: "Victoria Falls",          latitude: "-17.9243",   longitude: "25.8572")
    
}
