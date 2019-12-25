//
//  Icon.swift
//  Atum
//
//  Created by Wouter Willebrands on 24/12/2019.
//  Copyright © 2019 Studio Willebrands. All rights reserved.
//

import UIKit

//enum Icon {
//    case activeReminderIcon
//    case addIcon
//    case backIcon
//    case deleteIcon
//    case saveIcon
//    case compassIcon
//    case settingsIcon
//    case arrowIcon
//
//    var name: String {
//        switch self {
//        case .activeReminderIcon:    return "ActiveRemindersIcon"
//        case .addIcon:               return "AddIcon"
//        case .backIcon:              return "BackIcon"
//        case .deleteIcon:            return "DeleteIcon"
//        case .saveIcon:              return "SaveIcon"
//        case .compassIcon:           return "CompassIcon"
//        case .settingsIcon:          return "SettingsIcon"
//        case .arrowIcon:             return "ArrowIcon"
//        }
//    }
//}

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
    static let appBackgroundColor       = UIColor.Name(name: "AppBackgroundColor")
}
