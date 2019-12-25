//
//  Extension.swift
//  Atum
//
//  Created by Wouter Willebrands on 24/12/2019.
//  Copyright © 2019 Studio Willebrands. All rights reserved.
//

import UIKit

// MARK: Keyboard
extension UIViewController {
    // Hides keyboard when view is tapped
    func hideKeyboardOnBackgroundTap() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

// MARK: Alert
extension UIViewController {
    func presentAlert(description: String, viewController: UIViewController) {
        // Alert
        let alert = UIAlertController(title: nil, message: description, preferredStyle: .alert)
        
        let confirmation = UIAlertAction(title: "OK", style: .default) {
            (action) in alert.dismiss(animated: true, completion: nil)
        }
        
        alert.addAction(confirmation)
        viewController.present(alert, animated: true, completion: nil)
    }
    
//    func presentFailedPermissionActionSheet(description: String, viewController: UIViewController) {
//        // Actionsheet
//        let actionSheet = UIAlertController(title: nil, message: description, preferredStyle: .actionSheet)
//        
//        actionSheet.addAction(UIAlertAction(title: "Ok, take me to Settings", style: .default, handler: { (action) in
//            if let settingsURL = URL(string: UIApplication.openSettingsURLString + Bundle.main.bundleIdentifier!) {
//                UIApplication.shared.open(settingsURL, options: [:], completionHandler: nil)
//            }
//        }))
//        
//        actionSheet.addAction(UIAlertAction(title: "Thanks, but I'll go to settings later", style: .cancel, handler: { (action) in
//            
//        }))
//        
//        viewController.present(actionSheet, animated: true, completion: nil)
//    }
}
