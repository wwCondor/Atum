//
//  RoverPhotoDataManager.swift
//  Atum
//
//  Created by Wouter Willebrands on 30/12/2019.
//  Copyright © 2019 Studio Willebrands. All rights reserved.
//

import Foundation

class RoverPhotoDataManager {

    static let decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()

    static let session = URLSession(configuration: .default)
    
    typealias PhotosCompletionHandler = (RoverPhotos?, Error?)-> Void
    typealias PhotoCompletionHandler = ([Photo]?, Error?) -> Void
    
    static func fetchPhotos(rover: String, sol: Int, camera: String, completion: @escaping PhotoCompletionHandler) {
        let url = Endpoint.marsRover.url()//(rover: rover, sol: sol, camera: camera)
        print(url)
        
        var allPhotos = [Photo]()
        getRoverPhotos(url: url) { (photoData, error) in
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

    static func getRoverPhotos(url: URL, completion: @escaping PhotosCompletionHandler) {
        let request = URLRequest(url: url)

        let task = RoverPhotoDataManager.session.dataTask(with: request) { data, response, error in
                if let data = data {
                    guard let httpResponse = response as? HTTPURLResponse else {
                        completion(nil, NetworkingError.requestFailed)
                        return
                    }
                    if 200...299 ~= httpResponse.statusCode {
                        do {
                            let genres = try RoverPhotoDataManager.decoder.decode(RoverPhotos.self, from: data)
                            completion(genres, nil)
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
