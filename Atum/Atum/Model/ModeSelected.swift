//
//  ModeSelected.swift
//  Atum
//
//  Created by Wouter Willebrands on 25/12/2019.
//  Copyright © 2019 Studio Willebrands. All rights reserved.
//

import Foundation

enum ModeSelected {
    case marsRoverMode
    case eyeInTheSkyMode
    case slidingPuzzleMode
    
        var name: String {
            switch self {
            case .marsRoverMode:         return "Mars Rover"
            case .eyeInTheSkyMode:       return "Eye in the Sky"
            case .slidingPuzzleMode:     return "Sliding Puzzle"
            }
        }
}

//enum rocketEngineState {
//    case activeEngine
//    case inactiveEngine
//}
