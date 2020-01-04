//
//  RoverPhotos.swift
//  Atum
//
//  Created by Wouter Willebrands on 30/12/2019.
//  Copyright © 2019 Studio Willebrands. All rights reserved.
//

import Foundation

struct RoverPhotos: Codable {
    let photos: [RoverPhoto]
}

struct RoverPhoto: Codable {
    let imgSrc: String
    let earthDate: String
}

struct EyeInTheSkyPhoto: Codable {
    let date: String
    let url: String
}

struct BlueMarbleDate: Codable {
    let date: String
}

struct BlueMarblePhoto: Codable {
    let image: String
}
