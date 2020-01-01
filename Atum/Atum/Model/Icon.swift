//
//  Icon.swift
//  Atum
//
//  Created by Wouter Willebrands on 24/12/2019.
//  Copyright © 2019 Studio Willebrands. All rights reserved.
//

import UIKit

extension UIImage {
    struct Name: RawRepresentable {
        typealias RawValue = String

        var rawValue: RawValue

        var name: String { return rawValue}

        init(rawValue: String) {
            self.rawValue = rawValue
        }

        init(name: String) {
            self.init(rawValue: name)
        }
    }

    convenience init?(named: Name) {
        self.init(named: named.name)
    }
}

extension UIImage.Name {
//    static let rocketIcon            = UIImage.Name(name: "RocketIcon")
    static let inactiveRocketIcon    = UIImage.Name(name: "InactiveRocketIcon")
    static let activeRocketIcon      = UIImage.Name(name: "ActiveRocketIcon")
    
    static let sendIcon              = UIImage.Name(name: "SendIcon")

//    static let menuIcon              = UIImage.Name(name: "MenuIcon")
//    static let slideMenuIcon         = UIImage.Name(name: "SlideMenuIcon")
    static let roverIcon             = UIImage.Name(name: "RoverIcon")
    static let skyEyeIcon            = UIImage.Name(name: "SkyEyeIcon")
    static let puzzleIcon            = UIImage.Name(name: "PuzzleIcon")
    static let planetIcon            = UIImage.Name(name: "PlanetIcon")
    
    static let arrowIcon             = UIImage.Name(name: "ArrowIcon") 
    
    static let placeholderImage         = UIImage.Name(name: "PlaceholderImage")
    static let satImagePlaceHolder      = UIImage.Name(name: "SatImagePlaceHolder")
    static let marbleImagePlaceholder   = UIImage.Name(name: "MarblePlaceholder")

    
}
