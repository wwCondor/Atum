//
//  NavigationButton.swift
//  Atum
//
//  Created by Wouter Willebrands on 26/12/2019.
//  Copyright © 2019 Studio Willebrands. All rights reserved.
//

import UIKit

// Triangle shaped buttons with rounded corners
class RightNavigator: NavigationButton {
    
    override func draw(_ rect: CGRect) {
        let width = self.bounds.size.width
        let height = self.bounds.size.height
        let offset: CGFloat = 10
        
        let p1 = CGPoint(x: offset, y: offset)
        let p2 = CGPoint(x: width - offset, y: height / 2 - offset)
        let p3 = CGPoint(x: width, y: height / 2)
        let p4 = CGPoint(x: width - offset, y: height / 2 + offset)
        let p5 = CGPoint(x: offset, y: height - offset)
        let p6 = CGPoint(x: 0, y: height)
        let p7 = CGPoint(x: 0, y: height - offset)
        let p8 = CGPoint(x: 0, y: offset)
        let p9 = CGPoint(x: 0, y: 0)

        let path = UIBezierPath()

        navigatorColor.setFill()

        path.move(to: p1)
        path.addLine(to: p2)
        path.addQuadCurve(to: p4, controlPoint: p3)
        path.addLine(to: p5)
        path.addQuadCurve(to: p7, controlPoint: p6)
        path.addLine(to: p8)
        path.addQuadCurve(to: p1, controlPoint: p9)
        path.close()
        path.fill()
    }
}

class LeftNavigator: NavigationButton {
    
    override func draw(_ rect: CGRect) {
        let width = self.bounds.size.width
        let height = self.bounds.size.height
        let offset: CGFloat = 10
        
        let p1 = CGPoint(x: offset, y: height/2 - offset)
        let p2 = CGPoint(x: width - offset, y: offset)
        let p3 = CGPoint(x: width, y: 0)
        let p4 = CGPoint(x: width, y: offset)
        let p5 = CGPoint(x: width, y: height - offset)
        let p6 = CGPoint(x: width, y: height)
        let p7 = CGPoint(x: width - offset, y: height - offset)
        let p8 = CGPoint(x: offset, y: height / 2 + offset)
        let p9 = CGPoint(x: 0, y: height / 2)

        let path = UIBezierPath()

        navigatorColor.setFill()

        path.move(to: p1)
        path.addLine(to: p2)
        path.addQuadCurve(to: p4, controlPoint: p3)
        path.addLine(to: p5)
        path.addQuadCurve(to: p7, controlPoint: p6)
        path.addLine(to: p8)
        path.addQuadCurve(to: p1, controlPoint: p9)
        path.close()
        path.fill()
    }
}

class NavigationButton: UIView {
    
    let navigatorColor = UIColor(named: .iconColor)!

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    func setupView() {
        backgroundColor = UIColor.clear
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.9
        layer.shadowOffset = CGSize(width: 0.5, height: 1.0)
        layer.shadowRadius = 5
        isUserInteractionEnabled = true
        translatesAutoresizingMaskIntoConstraints = false
    }
}
