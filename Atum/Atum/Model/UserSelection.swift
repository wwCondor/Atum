//
//  User.swift
//  Atum
//
//  Created by Wouter Willebrands on 02/01/2020.
//  Copyright © 2020 Studio Willebrands. All rights reserved.
//

import Foundation

struct MarsRoverQueryData {
    // Mars rover selected data
    var selectedRoverCamera: RoverCamera
    var selectedRoverPhotoDate: String
    static var userRoverDataSelections = MarsRoverQueryData(selectedRoverCamera: RoverCamera.fhaz, selectedRoverPhotoDate: "2015-08-06")
}

struct SkyEyeQueryData {
    var selectedLocation: Location
    var selectedZoomLevel: String
//    static var userEyeDataSelections = UserEyeSelection(selectedLocation:         , selectedZoomLevel:            )
}
