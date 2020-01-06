//
//  User.swift
//  Atum
//
//  Created by Wouter Willebrands on 02/01/2020.
//  Copyright © 2020 Studio Willebrands. All rights reserved.
//

import Foundation

struct MarsRoverQueryData {
    var selectedRoverCamera: RoverCamera
    var selectedRoverPhotoDate: String
    static var userRoverDataSelections = MarsRoverQueryData(selectedRoverCamera: RoverCamera.fhaz, selectedRoverPhotoDate: PlaceHolderText.roverInitialDate)
}

struct SkyEyeQueryData {
    var selectedLocation: Location
    var selectedZoomLevel: String
    static var userEyeDataSelections = SkyEyeQueryData(selectedLocation: .mountEverest, selectedZoomLevel: PlaceHolderText.initalZoomLevel)
}

struct BlueMarbleQueryData {
    var selectedDate: String
    static var userBlueMarbleDataSelection = BlueMarbleQueryData(selectedDate: PlaceHolderText.blueMarbleInitialDate)
}
