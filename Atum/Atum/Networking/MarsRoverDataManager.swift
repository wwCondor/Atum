//
//  MarsRoverDataManager.swift
//  Atum
//
//  Created by Wouter Willebrands on 30/12/2019.
//  Copyright © 2019 Studio Willebrands. All rights reserved.
//

import Foundation

struct MarsRoverDataManager {
    typealias PhotosCompletionHandler = (RoverPhotos?, Error?)-> Void
    typealias PhotoCompletionHandler = ([RoverPhoto]?, Error?) -> Void
    
    static func getPhotos(date: String, camera: String, completion: @escaping PhotoCompletionHandler) {
        let url = Endpoint.marsRover.url()
        print("Rover photo retrieval URL: \(url)")
        
        var allPhotos = [RoverPhoto]()
        getPhotoData(url: url) { (photoData, error) in
            guard let photos = photoData?.photos else {
                completion(nil, NetworkingError.invalidData)
                return
            }
            for photo in photos {
                allPhotos.append(photo)
            }
            completion(allPhotos, nil)
        }
    }
    
    static private func getPhotoData(url: URL, completion: @escaping PhotosCompletionHandler) {
        Networker.request(url: url) { (result) in
            switch result {
            case .success(let data):
                guard let photos = try? JSONDecoder.dataDecoder.decode(RoverPhotos.self, from: data) else { return }
                completion(photos, nil)
            case .failure(let error):
                completion(nil, error)
            }
        }
    }
}
