//
//  User.swift
//  Atum
//
//  Created by Wouter Willebrands on 02/01/2020.
//  Copyright © 2020 Studio Willebrands. All rights reserved.
//

import Foundation

struct UserSelection {
    var selectedRoverCamera: RoverCamera
    var selectedRoverPhotoDate: String
    
    static var userRoverDataSelections = UserSelection(selectedRoverCamera: RoverCamera.fhaz, selectedRoverPhotoDate: "2015-08-06") //
}
