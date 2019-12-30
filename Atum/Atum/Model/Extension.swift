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

extension UIImage {
//    func imageWithInsets(insets: UIEdgeInsets) -> UIImage? {
//        UIGraphicsBeginImageContextWithOptions(
//            CGSize(width: self.size.width + insets.left + insets.right,
//                   height: self.size.height + insets.top + insets.bottom), false, self.scale)
//        let _ = UIGraphicsGetCurrentContext()
//        let origin = CGPoint(x: insets.left, y: insets.top)
//        self.draw(at: origin)
//        let imageWithInsets = UIGraphicsGetImageFromCurrentImageContext()
//        UIGraphicsEndImageContext()
//        return imageWithInsets
//    }
//
//    func withBottomInset(inset: UIEdgeInsets) -> UIImage? {
//        UIGraphicsBeginImageContextWithOptions(
//            CGSize(width: self.size.width,
//                   height: self.size.height + inset.bottom), false, self.scale)
//        let _ = UIGraphicsGetCurrentContext()
//        let origin = CGPoint(x: 0, y: inset.bottom)
//        self.draw(at: origin)
//        let imageWithInsets = UIGraphicsGetImageFromCurrentImageContext()
//        UIGraphicsEndImageContext()
//        return imageWithInsets
//
//    }
    
    func withBottomInset(inset: CGFloat) -> UIImage? {
        let width: CGFloat = size.width
        let height: CGFloat = size.height + inset
        UIGraphicsBeginImageContextWithOptions(CGSize(width: width, height: height), false, 0)
        let origin: CGPoint = CGPoint(x: 0, y: 0) // (height - size.height) / 2
        draw(at: origin)
        let imageWithPadding = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return imageWithPadding
    }
}

extension UIView {
    // Used to make specific corners round
    public func roundViewCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
}

extension UIButton{
    public func roundButtonCorners(corners: UIRectCorner, radius: CGFloat){
        let maskPath1 = UIBezierPath(roundedRect: bounds,
            byRoundingCorners: [corners],
            cornerRadii: CGSize(width: radius, height: radius))
        let maskLayer1 = CAShapeLayer()
        maskLayer1.frame = bounds
        maskLayer1.path = maskPath1.cgPath
        layer.mask = maskLayer1
    }
}

extension JSONDecoder {
    static var dataDecoder: JSONDecoder {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }
}
