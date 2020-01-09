//
//  LocationSliderManager.swift
//  Atum
//
//  Created by Wouter Willebrands on 09/01/2020.
//  Copyright © 2020 Studio Willebrands. All rights reserved.
//

import UIKit
import MapKit

protocol LocationDelegate {
    func newLocationSelected(location: Location)
}

class LocationManagerSlider: NSObject {
    
    let cellId = "locationCell"
    
    let searchCompleter = MKLocalSearchCompleter()
    var searchResults = [MKLocalSearchCompletion]()
    var locationDelegate: LocationDelegate!
    
    lazy var fadeView: UIView = {
        let fadeView = UIView()
        fadeView.alpha = 0
        fadeView.backgroundColor = UIColor.black
        fadeView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismissSlider(sender:))))
        return fadeView
    }()
    
    lazy var sliderView: UIView = {
        let sliderView = UIView()
        sliderView.translatesAutoresizingMaskIntoConstraints = false
        sliderView.backgroundColor = UIColor(named: .objectColor)
        sliderView.layer.masksToBounds = true
        sliderView.addBorders(edges: [.top], color: UIColor(named: .objectBorderColor)!)
        let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(dismissSlider(sender:)))
        swipeGesture.direction = .down
        sliderView.addGestureRecognizer(swipeGesture)
        return sliderView
    }()
    
    lazy var locationSearchBar: UISearchBar = {
        let locationSearchBar = UISearchBar()
        locationSearchBar.translatesAutoresizingMaskIntoConstraints = false
        locationSearchBar.isTranslucent = false
        locationSearchBar.delegate = self
        locationSearchBar.placeholder = PlaceHolderText.enterLocation
        locationSearchBar.layer.masksToBounds = true
        locationSearchBar.layer.cornerRadius = Constant.smallCornerRadius
        locationSearchBar.layer.borderWidth = Constant.textFieldBorderWidth
        locationSearchBar.layer.borderColor = UIColor(named: .objectBorderColor)?.cgColor
        locationSearchBar.searchTextField.backgroundColor = UIColor.clear // Gets rid of colored padding
        locationSearchBar.barTintColor = UIColor(named: .appBackgroundColor)
        locationSearchBar.tintColor = UIColor(named: .iconSliderColor) // Sets vertical bar "caret" color
        locationSearchBar.searchTextField.textColor = UIColor(named: .textTintColor)
        locationSearchBar.searchTextField.font = UIFont.systemFont(ofSize: 13.0, weight: .medium)
        locationSearchBar.keyboardAppearance = .dark
        locationSearchBar.returnKeyType = .done
        return locationSearchBar
    }()
    
    lazy var searchResultsTableView: UITableView = {
        let searchResultsTableView = UITableView()
        searchResultsTableView.backgroundColor = UIColor(named: .appBackgroundColor)
        searchResultsTableView.layer.masksToBounds = true
        searchResultsTableView.layer.cornerRadius = Constant.largeCornerRadius
        searchResultsTableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        searchResultsTableView.dataSource = self
        searchResultsTableView.delegate = self
        searchResultsTableView.translatesAutoresizingMaskIntoConstraints = false
        return searchResultsTableView
    }()
    
    override init() {
        super.init()
        setDelegate()
    }
    
    private func setDelegate() {
        searchCompleter.delegate = self
    }
    
    private func clearSearchResults() {
        locationSearchBar.text = ""
        locationSearchBar.placeholder = PlaceHolderText.enterLocation
        searchResults.removeAll()
        searchResultsTableView.reloadData()
    }
    
    func presentSlider() {
        clearSearchResults()
        hideKeyboardOnBackgroundTap()

        let window = UIApplication.shared.windows.first { $0.isKeyWindow }
        if let window = window {
            
            window.addSubview(fadeView)
            window.addSubview(sliderView)
            window.addSubview(locationSearchBar)
            window.addSubview(searchResultsTableView)

            fadeView.frame = window.frame
            
            let windowHeight: CGFloat = window.frame.height
            let contentWidth: CGFloat = (3/4)*window.frame.width

            NSLayoutConstraint.activate([
                sliderView.leadingAnchor.constraint(equalTo: window.leadingAnchor),
                sliderView.trailingAnchor.constraint(equalTo: window.trailingAnchor),
                sliderView.topAnchor.constraint(equalTo: window.centerYAnchor, constant: -window.frame.height/4),
                sliderView.bottomAnchor.constraint(equalTo: window.bottomAnchor),
                                
                locationSearchBar.topAnchor.constraint(equalTo: sliderView.topAnchor, constant: Constant.contentPadding),
                locationSearchBar.widthAnchor.constraint(equalToConstant: contentWidth),
                locationSearchBar.heightAnchor.constraint(equalToConstant: Constant.emailInputFieldHeight),
                locationSearchBar.centerXAnchor.constraint(equalTo: sliderView.centerXAnchor),
                
                searchResultsTableView.topAnchor.constraint(equalTo: locationSearchBar.bottomAnchor, constant: Constant.contentPadding),
                searchResultsTableView.leadingAnchor.constraint(equalTo: locationSearchBar.leadingAnchor),
                searchResultsTableView.trailingAnchor.constraint(equalTo: locationSearchBar.trailingAnchor),
                searchResultsTableView.bottomAnchor.constraint(equalTo: window.safeAreaLayoutGuide.bottomAnchor, constant: -Constant.bottomContentPadding),
            ])
            
            UIView.animate(
                withDuration: 0.5,
                delay: 0,
                options: .curveEaseOut,
                animations: {
                    self.fadeView.alpha = 0.4
                    self.sliderView.center.y -= windowHeight
                    self.locationSearchBar.center.y -= windowHeight
                    self.searchResultsTableView.center.y -= windowHeight
            },
                completion: nil)
        }
    }
    
    @objc private func dismissSlider(sender: UISwipeGestureRecognizer) {
        dismissSliderMenu()
    }
    
    private func dismissSliderMenu() {
        UIView.animate(
            withDuration: 0.3,
            delay: 0,
            options: .curveEaseIn,
            animations: {
                self.fadeView.alpha = 0
                self.sliderView.center.y += self.sliderView.bounds.height
                self.locationSearchBar.center.y += self.sliderView.bounds.height
                self.searchResultsTableView.center.y += self.sliderView.bounds.height
        },
            completion: { _ in
                self.fadeView.removeFromSuperview()
                self.sliderView.removeFromSuperview()
                self.locationSearchBar.removeFromSuperview()
                self.searchResultsTableView.removeFromSuperview()
        })
    }
}

extension LocationManagerSlider: UISearchBarDelegate {
    // Handles changes in text
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchBar.becomeFirstResponder()
        searchCompleter.queryFragment = searchText
    }
}

extension LocationManagerSlider: MKLocalSearchCompleterDelegate {
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        searchResults = completer.results
        searchResultsTableView.reloadData()
    }
    
    func completer(_ completer: MKLocalSearchCompleter, didFailWithError error: Error) {
        let window = UIApplication.shared.windows.first { $0.isKeyWindow }
        if let window = window {
            guard let viewController = window.rootViewController else { return }
            viewController.presentAlert(description: error.localizedDescription, viewController: viewController)
        }
    }
}

extension LocationManagerSlider: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let searchResult = searchResults[indexPath.row]
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
        cell.selectionStyle = .none
        cell.textLabel?.text = searchResult.title
        cell.detailTextLabel?.text = searchResult.subtitle
        cell.textLabel?.textColor = UIColor(named: .textTintColor)
        cell.detailTextLabel?.textColor = UIColor(named: .textTintColor)
        cell.backgroundColor = UIColor(named: .appBackgroundColor)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        locationSearchBar.resignFirstResponder()
        let completion = searchResults[indexPath.row]
        let searchRequest = MKLocalSearch.Request(completion: completion)
        let search = MKLocalSearch(request: searchRequest)
        search.start { (result, error) in
            guard let coordinate = result?.mapItems.last?.placemark.coordinate else { return }
            let locationName: String = completion.title
            let latitude: String = coordinate.latitude.toString
            let longitude: String = coordinate.longitude.toString
            let selectedLocation: Location = Location(locationName: locationName, latitude: latitude, longitude: longitude)
            self.locationDelegate.newLocationSelected(location: selectedLocation)
            self.dismissSliderMenu()
        }
    }
}
