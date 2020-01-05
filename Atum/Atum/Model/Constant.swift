//
//  Constant.swift
//  Atum
//
//  Created by Wouter Willebrands on 25/12/2019.
//  Copyright © 2019 Studio Willebrands. All rights reserved.
//

import UIKit

struct Constant {
    // MenuBar
    static let menuBarHeight: CGFloat            = 60
    static let menuBarIconSize: CGFloat          = Constant.menuBarHeight/2
    static let horizontalSliderHeigth: CGFloat   = 5
    
    // SendButton
    static let sendButtonSize: CGFloat           = 60
    static let sendButtonBorderWidth: CGFloat    = 2
    static let sendButtonIconInset: CGFloat      = 12
    
    // Images above and underneath slider (not used atm)
//    static let sliderImageInsets: CGFloat        = -8
//    static let sliderImageViewSize: CGFloat      = 40
    
    // CameraButton
    static let cameraButtonHeigth: CGFloat       = 40

    // Corner radius for UIImageViews and MapView
    static let largeCornerRadius: CGFloat        = 10
    static let smallCornerRadius: CGFloat        = 5
    
    static let photoNavigatorOffset: CGFloat     = 2
    static let contentPadding: CGFloat           = 20
    static let contentSidePadding: CGFloat       = 30
    static let bottomContentPadding              = Constant.menuBarHeight + Constant.contentPadding

    // TextField
    static let textFieldHeight: CGFloat          = 20
    static let textFieldPadding: CGFloat         = 10
    static let textFieldBorderWidth: CGFloat     = 2
    static let textXInset: CGFloat               = 10
    static let textYInset: CGFloat               = 5
    
    static let croppedSquareSize: Double         = 300 // Reduced size to optimise UI response
    
    // Send Email Slider Content
    static let emailInputFieldHeight: CGFloat    = 40
    static let sliderBorderWidth: CGFloat        = 2
    static let itemSpacing: CGFloat              = 8
}

struct PlaceHolderText {
    static let noRoverPhotos: String             = "No photos for camera/date"
    static let postcardDefaultMessage: String    = "Your personal message"
    static let roverInitialDateValue: String     = "2015-08-06"
    static let initalZoomLevel: String           = "0.05"
    static let enterEmail: String                = "Enter Email"
    static let sendImageWithText: String         = "Add Text to Image"
    static let emailSubject: String              = "Image retrieved from one of the NASA API's with Atum app"
    static let emailBodyTextMars: String         = "I found this amazing image, made by the \(Rover.curiosity.name) Mars Rover's \(MarsRoverQueryData.userRoverDataSelections.selectedRoverCamera.fullName) on \(MarsRoverQueryData.userRoverDataSelections.selectedRoverPhotoDate), using the Atum application"
    static let emailBodyTextDSCOVR: String       = "I found this amazing image made by the DSCVR Spacecraft's Earth Polychromatic Imaging Camera (EPIC) using the Atum app."
}
