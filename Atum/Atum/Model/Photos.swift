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
//    let id: Int
//    let sol: Int
//    let camera: [CameraData]
    let imgSrc: String // Only thing used from API?
    let earthDate: String
//    let rover: RoverManifest
}

//struct CameraData: Codable {
//    let id: Int
//    let name: String
//    let roverId: Int
//    let fullName: String
//}
//
//struct RoverManifest: Codable {
//    let id: Int
//    let name: String
//    let landingDate: String
//    let launchDate: String
//    let status: String
//    let maxSol: Int
//    let maxDate: String
//    let totalPhotos: Int
//    let cameras: [Camera]
//}
//
//struct Camera: Codable {
//    let name: String
//    let fullName: String
//}

struct EyeInTheSkyPhoto: Codable {
    let date: String
    let url: String
}
