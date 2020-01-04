//
//  Extension.swift
//  Atum
//
//  Created by Wouter Willebrands on 24/12/2019.
//  Copyright © 2019 Studio Willebrands. All rights reserved.
//

import UIKit

// MARK: Keyboard
extension NSObject {
    // Hides keyboard when window is tapped
    func hideKeyboardOnBackgroundTap() {
        let window = UIApplication.shared.windows.first { $0.isKeyWindow }
        if let window = window {
            let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
            tap.cancelsTouchesInView = false
            window.addGestureRecognizer(tap)
        }
    }

    @objc func dismissKeyboard() {
        let window = UIApplication.shared.windows.first { $0.isKeyWindow }
        if let window = window {
            window.endEditing(true)
        }
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
}

extension UIImage {
    // Used to position rocket image
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

//extension UIView {
//    // Used to make specific corners round
//    public func roundViewCorners(corners: UIRectCorner, radius: CGFloat) {
//        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
//        let mask = CAShapeLayer()
//        mask.path = path.cgPath
//        layer.mask = mask
//    }
//}

//extension UIButton{
//    public func roundButtonCorners(corners: UIRectCorner, radius: CGFloat){
//        let maskPath1 = UIBezierPath(roundedRect: bounds,
//            byRoundingCorners: [corners],
//            cornerRadii: CGSize(width: radius, height: radius))
//        let maskLayer1 = CAShapeLayer()
//        maskLayer1.frame = bounds
//        maskLayer1.path = maskPath1.cgPath
//        layer.mask = maskLayer1
//    }
//}

extension JSONDecoder {
    static var dataDecoder: JSONDecoder {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }
}

extension UIImageView { 
    func fetchPhoto(from path: String) {//}, contentMode mode: UIView.ContentMode = .scaleAspectFit) {        
        let url = URL(string: "\(path)")!
//        print("Trying to obtain image from: \(url)")
        contentMode = .scaleAspectFit
        URLSession.shared.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async() {
                guard let httpResponse = response as? HTTPURLResponse else {
                    return
                }
                if httpResponse.statusCode == 200 {
                    guard let data = data else {
                        return
                    }
                    guard error == nil else {
                        return
                    }
                    guard let image = UIImage(data: data) else {
                        return
                    }
                    self.image = image.croppedToSquare(size: Constant.croppedSquareSize)
                } else {
                    print("Status Code: \(httpResponse.statusCode)")
                }
            }
        }.resume()
    }
    
    func fetchPhoto(date: String, imageName: String) {
        let fullDate: String = date
        let fullDateArray: [String] = fullDate.components(separatedBy: "-")
        
        let imageBaseURl: String = "https://epic.gsfc.nasa.gov/archive/natural/"
        
        let year: String = fullDateArray[0]
        let month: String = fullDateArray[1]
        let day: String = fullDateArray[2]
        
        let url = URL(string: "\(imageBaseURl)\(year)/\(month)/\(day)/jpg/\(imageName).jpg")! // Best quality: png .png, fastest: thumb .jpg
        print("Trying to obtain image from: \(url)")
        contentMode = .scaleAspectFit
        URLSession.shared.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async() {
                guard let httpResponse = response as? HTTPURLResponse else {
                    return
                }
                if httpResponse.statusCode == 200 {
                    guard let data = data else {
                        return
                    }
                    guard error == nil else {
                        return
                    }
                    guard let image = UIImage(data: data) else {
                        return
                    }
                    self.image = image.croppedToSquare(size: Constant.croppedSquareSize)
                } else {
                    print("Status Code: \(httpResponse.statusCode)")
                }
            }
        }.resume()
    }
}

extension UIImage {
    func croppedToSquare(size: Double) -> UIImage {
        let cgImage = self.cgImage!
        let contextImage: UIImage = UIImage(cgImage: cgImage)
        let contextSize: CGSize = contextImage.size
        var posX: CGFloat = 0.0
        var posY: CGFloat = 0.0
        var cgWidth: CGFloat = CGFloat(size)
        var cgHeight: CGFloat = CGFloat(size)

        // See what size is longer and create the center of that
        if contextSize.width > contextSize.height {
            posX = ((contextSize.width - contextSize.height) / 2)
            posY = 0
            cgWidth = contextSize.height
            cgHeight = contextSize.height
        } else {
            posX = 0
            posY = ((contextSize.height - contextSize.width) / 2)
            cgWidth = contextSize.width
            cgHeight = contextSize.width
        }

        let rect: CGRect = CGRect(x: posX, y: posY, width: cgWidth, height: cgHeight)

        // Create bitmap image from context using the rect
        let imageRef: CGImage = cgImage.cropping(to: rect)!

        // Create a new image based on the imageRef and rotate back to the original orientation
        let image: UIImage = UIImage(cgImage: imageRef, scale: self.scale, orientation: self.imageOrientation)

        return image
    }
}
