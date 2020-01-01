//
//  PageController.swift
//  Atum
//
//  Created by Wouter Willebrands on 31/12/2019.
//  Copyright © 2019 Studio Willebrands. All rights reserved.
//

import UIKit

//protocol PageIndexDelegate: class {
//    func pageViewController(pageViewController: PageViewController,
//    didUpdatePageCount count: Int)
//
//    func pageViewController(pageViewController: PageViewController,
//    didUpdatePageIndex index: Int)
//}

class PageViewController: UIPageViewController {
    
//    weak var pageDelegate: PageIndexDelegate?
    
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
    
//    lazy var pageControl: PageControl = {
//        let pageControl = PageControl(frame: .zero)
//        pageControl.numberOfPages = pages.count
//        return pageControl
//    }()
    
    lazy var menuBar: MenuBar = {
        let menuBar = MenuBar()
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
        
//        pageDelegate?.pageViewController(pageViewController: self, didUpdatePageCount: pages.count)
        
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
//        view.addSubview(collectionView)
//        view.addSubview(pageViewController)
        view.addSubview(menuBar)
//        view.addSubview(pageControl)
        
        NSLayoutConstraint.activate([
//            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
//            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//            collectionView.bottomAnchor.constraint(equalTo: menuBar.topAnchor),
            
            menuBar.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            menuBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            menuBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            menuBar.heightAnchor.constraint(equalToConstant: Constant.menuBarHeight)
            
//            pageControl.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
//            pageControl.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//            pageControl.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//            pageControl.heightAnchor.constraint(equalToConstant: Constant.menuBarHeight)
        ])
    }
    
    private func setupRocketIcon() {
        let logoImageViewWidth = navigationController!.navigationBar.frame.size.width/3
        let logoImageHeight = navigationController!.navigationBar.frame.size.height
        logoImageView.frame = CGRect(x: 0, y: 0, width: logoImageViewWidth, height: logoImageHeight)
        navigationItem.titleView = logoImageView
    }
    
    private func getViewController(withIdentifier identifier: String) -> UIViewController {
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: identifier)
    }
    
    @objc private func activateRocket(sender: UITapGestureRecognizer) {
        // In here we have an ignition sound
        // image change to activeRocketIcon
        // motion departure
        // motion arriving
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
    
    
//    func presentationCount(for pageViewController: UIPageViewController) -> Int {
//        <#code#>
//    }
//
//    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
//        <#code#>
//    }
}

extension PageViewController: UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        print("Turned Page")
        if let firstViewController = viewControllers?.first,
            let index = pages.firstIndex(of: firstViewController) {
            
            currentPage = index
//            menuBar.currentPage = index
            
            menuBar.updateMenuBar(to: index)
            
//            menuBar.collectionView.selectItem(at: index, animated: true, scrollPosition: [])
//            menuBar.collectionView.reloadData()
//            print("PVC at page:\(currentPage)")
//            print("MenuBar at page:\(menuBar.currentPage)")
            // Here we have the index of the page we are at. Use this to update the menubar?
            
//            pageDelegate?.pageViewController(pageViewController: self, didUpdatePageIndex: index)
        }
    }
}
