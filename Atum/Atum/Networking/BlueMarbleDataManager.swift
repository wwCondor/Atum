//
//  BlueMarbleDataManager.swift
//  Atum
//
//  Created by Wouter Willebrands on 30/12/2019.
//  Copyright © 2019 Studio Willebrands. All rights reserved.
//

import Foundation

class BlueMarbleDataManager {
    
    // Blue Marble Dates
    typealias DatesCompletionHandler = ([BlueMarbleDate]?, Error?) -> Void
    
    static func getDates(completion: @escaping DatesCompletionHandler) {
        let url = Endpoint.blueMarbleDates.url()
        print("Blue Marble Dates URL: \(url)")
        
        var allDates = [BlueMarbleDate]()
        Networker.request(url: url) { (result) in
            switch result {
            case .success(let data):
                guard let dates = try? JSONDecoder.dataDecoder.decode([BlueMarbleDate].self, from: data) else { return }
                for date in dates {
                    allDates.append(date)
                }
                completion(dates, nil)
            case .failure(let error):
                completion(nil, error)
            }
        }
    }
    
    // Blue Marble Photos
    typealias PhotosCompletionHandler = ([BlueMarblePhoto]?, Error?) -> Void

    static func getPhotos(date: String, completion: @escaping PhotosCompletionHandler) {
        let url = Endpoint.blueMarblePhotos.url()
        print("Blue Marble Image URL: \(url)")

        var allPhotos = [BlueMarblePhoto]()
        Networker.request(url: url) { (result) in
            switch result {
            case .success(let data):
                guard let photos = try? JSONDecoder.dataDecoder.decode([BlueMarblePhoto].self, from: data) else { return }
                for photo in photos {
                    allPhotos.append(photo)
                }
                completion(photos, nil)
            case .failure(let error):
                completion(nil, error)
            }
        }
    }
}
