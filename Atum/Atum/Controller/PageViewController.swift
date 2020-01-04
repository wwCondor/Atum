//
//  PageController.swift
//  Atum
//
//  Created by Wouter Willebrands on 31/12/2019.
//  Copyright © 2019 Studio Willebrands. All rights reserved.
//

import UIKit

class PageViewController: UIPageViewController {
    
    var currentPage: Int = 0
    
    lazy var pages: [UIViewController] = {
        return [
            self.getViewController(withIdentifier: "marsRoverID"),
            self.getViewController(withIdentifier: "skyEyeID"),
            self.getViewController(withIdentifier: "blueMarbleID")
        ]
    }()
    
    lazy var logoImageView: UIImageView = {
        let image = UIImage(named: .inactiveRocketIcon)?.withRenderingMode(.alwaysOriginal).withBottomInset(inset: 70)
        let logoImageView = UIImageView(image: image)
        logoImageView.isUserInteractionEnabled = true
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(activateRocket(sender:)))
        logoImageView.addGestureRecognizer(tapGesture)
        logoImageView.contentMode = .scaleAspectFit
        return logoImageView
    }()
    
    lazy var menuBar: MenuBar = {
        let menuBar = MenuBar()
        menuBar.addBorders(edges: [.top], color: UIColor(named: .objectBorderColor)!)
        menuBar.pageViewController = self // creates reference inside menuBar
        return menuBar
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = self
        delegate = self
        
        setupRocketIcon()
        setupMenuBar()
        
        if let firstViewController = pages.first {
            setViewControllers([firstViewController], direction: .forward, animated: true, completion: nil)
        }
    }
    
    func navigateToPage(number: Int) {
        if number > currentPage {
            let destinationViewController: UIViewController = pages[number]
            setViewControllers([destinationViewController], direction: .forward, animated: true, completion: nil)
        } else if number < currentPage {
            let destinationViewController: UIViewController = pages[number]
            setViewControllers([destinationViewController], direction: .reverse, animated: true, completion: nil)
        }
        currentPage = number
        print(currentPage)
    }
    
    private func setupMenuBar() {
        view.addSubview(menuBar)
        
        NSLayoutConstraint.activate([
            menuBar.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            menuBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            menuBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            menuBar.heightAnchor.constraint(equalToConstant: Constant.menuBarHeight)
        ])
    }
    
    private func setupRocketIcon() {
        let logoImageViewWidth = navigationController!.navigationBar.frame.size.width/3
        let logoImageHeight = navigationController!.navigationBar.frame.size.height
        logoImageView.frame = CGRect(x: 0, y: 0, width: logoImageViewWidth, height: logoImageHeight)
        navigationItem.titleView = logoImageView
        navigationController?.navigationBar.addBorders(edges: [.bottom], color: UIColor(named: .objectBorderColor)!)
    }
    
    private func getViewController(withIdentifier identifier: String) -> UIViewController {
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: identifier)
    }
    
    @objc private func activateRocket(sender: UITapGestureRecognizer) {
        print("Whooooooshhh!")
    }
}

extension PageViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = pages.firstIndex(of: viewController) else { return nil }
        
        let previousIndex = viewControllerIndex - 1
        
        guard previousIndex >= 0 else { return pages.last }
        
        guard pages.count > previousIndex else { return nil }
        
        return pages[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = pages.firstIndex(of: viewController) else { return nil }
        
        let nextIndex = viewControllerIndex + 1
        
        guard nextIndex < pages.count else { return pages.first }
        
        guard pages.count > nextIndex else { return nil }
        
        return pages[nextIndex]
    }
}

extension PageViewController: UIPageViewControllerDelegate {
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if let firstViewController = viewControllers?.first,
            let index = pages.firstIndex(of: firstViewController) {
            currentPage = index
            menuBar.updateMenuBar(to: index)
        }
    }
}
