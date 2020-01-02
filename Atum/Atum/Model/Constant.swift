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
    
    // Images above and underneath slider
    static let sliderImageInsets: CGFloat        = -8
    static let sliderImageViewSize: CGFloat      = 40
    
    // CameraButton
    static let cameraButtonHeigth: CGFloat       = 60

    // Corner radius for UIImageViews and MapView
    static let largeCornerRadius: CGFloat        = 10
    static let smallCornerRadius: CGFloat        = 5
    
    static let contentPadding: CGFloat           = 30
    static let contentSidePadding: CGFloat       = 30
    static let bottomContentPadding              = Constant.menuBarHeight + Constant.contentPadding

    // TextField
    static let textFieldHeight: CGFloat          = 20
    static let textFieldPadding: CGFloat         = 10
    static let textFieldBorderWidth: CGFloat     = 2
    static let textXInset: CGFloat               = 10
    static let textYInset: CGFloat               = 5
}


struct PlaceHolderText {
    static let noRoverPhotos: String             = "No photos for camera/date"
}

