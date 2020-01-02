//
//  Rover.swift
//  Atum
//
//  Created by Wouter Willebrands on 30/12/2019.
//  Copyright © 2019 Studio Willebrands. All rights reserved.
//

import Foundation

enum Rover {
    case curiosity
    
    var name: String {
        switch self {
        case .curiosity:      return "Curiosity"
        }
    }
}

enum RoverCamera {
    case fhaz
    case rhaz
    case mast
    case chemcam
    case mahli
    case mardi
    case navcam
    
    // Used for cameraSelectionButton
    var fullName: String {
        switch self {
        case .fhaz:           return "Front Hazard Avoidance Camera"
        case .rhaz:           return "Rear Hazard Avoidance Camera"
        case .mast:           return "Mast Camera"
        case .chemcam:        return "Chemistry and Camera Complex"
        case .mahli:          return "Mars Hand Lens Imager"
        case .mardi:          return "Mars Decent Imager"
        case .navcam:         return "Navigation Camera"
        }
    }
    
    // Used for Postcard metadata
    var abbreviation: String {
        switch self {
        case .fhaz:           return "FHAZ"
        case .rhaz:           return "RHAZ"
        case .mast:           return "MAST"
        case .chemcam:        return "CHEMCAM"
        case .mahli:          return "MAHLI"
        case .mardi:          return "MARDI"
        case .navcam:         return "NAVCAM"
        }
    }
}
