//
//  BlueMarbleDataManager.swift
//  Atum
//
//  Created by Wouter Willebrands on 30/12/2019.
//  Copyright © 2019 Studio Willebrands. All rights reserved.
//

import Foundation

class BlueMarbleDataManager {
    
    static let session = URLSession(configuration: .default)
    
    typealias PhotosCompletionHandler = ([BlueMarblePhoto]?, Error?) -> Void
    
    static func fetchPhotos(date: String, completion: @escaping PhotosCompletionHandler) {
        let url = Endpoint.blueMarbleImages.url()
        print("Blue Marble Image URL: \(url)")
        
        var allPhotos = [BlueMarblePhoto]()
        fetchPhotoData(url: url) { (photoData, error) in
            guard let photos = photoData else {
                completion(nil, NetworkingError.invalidData)
                return
            }
            for photo in photos {
                allPhotos.append(photo)
            }
            completion(allPhotos, nil)
        }
    }

    static private func fetchPhotoData(url: URL, completion: @escaping PhotosCompletionHandler) {
        let request = URLRequest(url: url)
        
        let task = session.dataTask(with: request) { data, response, error in
            if let data = data {
                guard let httpResponse = response as? HTTPURLResponse else {
                    completion(nil, NetworkingError.requestFailed)
                    return
                }
                if 200...299 ~= httpResponse.statusCode {
                    do {
                        let photos = try JSONDecoder.dataDecoder.decode([BlueMarblePhoto].self, from: data)
                        completion(photos, nil)
                    } catch {
                        completion(nil, NetworkingError.jsonDecodingFailure)
                    }
                } else {
                    completion(nil, NetworkingError.responseUnsuccessful)
                }
            } else {
                completion(nil, NetworkingError.noData)
            }
        }
        task.resume()
    }
    
    
    // Blue Marble Dates
    typealias DatesCompletionHandler = ([BlueMarbleDate]?, Error?) -> Void

    static func fetchDates(completion: @escaping DatesCompletionHandler) {
        let url = Endpoint.blueMarbleDates.url()
        print("Blue Marble Dates URL: \(url)")

        var allDates = [BlueMarbleDate]()
        fetchData(url: url) { (dateData, error) in
            guard let dates = dateData else {
                completion(nil, NetworkingError.invalidData)
                return
            }
            for date in dates {
                allDates.append(date)
            }
            completion(allDates, nil)
        }
    }
    
    static private func fetchData(url: URL, completion: @escaping DatesCompletionHandler) {
        let request = URLRequest(url: url)
        
        let task = session.dataTask(with: request) { data, response, error in
            if let data = data {
                guard let httpResponse = response as? HTTPURLResponse else {
                    completion(nil, NetworkingError.requestFailed)
                    return
                }
                if 200...299 ~= httpResponse.statusCode {
                    do {
                        let dates = try JSONDecoder.dataDecoder.decode([BlueMarbleDate].self, from: data)
                        completion(dates, nil)
                    } catch {
                        completion(nil, NetworkingError.jsonDecodingFailure)
                    }
                } else {
                    completion(nil, NetworkingError.responseUnsuccessful)
                }
            } else {
                completion(nil, NetworkingError.noData)
            }
        }
        task.resume()
    }
}


