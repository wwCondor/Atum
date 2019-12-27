//
//  SlideMenuManager.swift
//  Atum
//
//  Created by Wouter Willebrands on 26/12/2019.
//  Copyright © 2019 Studio Willebrands. All rights reserved.
//

import UIKit

class SlideMenuManager: NSObject {

    lazy var fadeView: UIView = {
        let fadeView = UIView()
        fadeView.alpha = 0
        fadeView.backgroundColor = UIColor(named: .appBackgroundColor)
        fadeView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismissMenu(sender:))))
        return fadeView
    }()

    lazy var menuOptions: UIView = {
        let menuOptions = UIView()
        menuOptions.translatesAutoresizingMaskIntoConstraints = false
        menuOptions.backgroundColor = UIColor(named: .objectColor)
        let swipeLeftGesture = UISwipeGestureRecognizer(target: self, action: #selector(dismissMenu(sender:)))
        menuOptions.addGestureRecognizer(swipeLeftGesture)
        return menuOptions
    }()

    override init() {
        super.init()
//        addObserver()
    }

    func presentMenu() {
        let window = UIApplication.shared.windows.first { $0.isKeyWindow }
        if let window = window {

            let menuHeigth = 2*Constant.menuButtonSize

            window.addSubview(fadeView)
            window.addSubview(menuOptions)

            fadeView.frame = window.frame

            NSLayoutConstraint.activate([
                menuOptions.widthAnchor.constraint(equalToConstant: window.frame.width),
                menuOptions.topAnchor.constraint(equalTo: window.safeAreaLayoutGuide.bottomAnchor, constant: -menuHeigth),
                menuOptions.bottomAnchor.constraint(equalTo: window.bottomAnchor, constant: Constant.menuButtonSize),
                menuOptions.heightAnchor.constraint(equalToConstant: Constant.menuButtonSize)
            ])

            UIView.animate(
                withDuration: 0.5,
                delay: 0,
                options: .curveEaseIn,
                animations: {
                    self.fadeView.alpha = 0.5
                    self.menuOptions.center.y -= self.menuOptions.frame.height
            },
                completion: nil)
        }
    }

    @objc private func dismissMenu(sender: UISwipeGestureRecognizer) {
        UIView.animate(
            withDuration: 0.3,
            delay: 0,
            options: .curveEaseIn,
            animations: {
                self.fadeView.alpha = 0
                self.menuOptions.center.y += self.menuOptions.frame.height
        },
            completion: { _ in
                self.fadeView.removeFromSuperview()
                self.menuOptions.removeFromSuperview()
        })
    }
}
