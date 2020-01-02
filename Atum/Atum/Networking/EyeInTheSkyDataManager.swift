//
//  EyeInTheSkyDataManager.swift
//  Atum
//
//  Created by Wouter Willebrands on 02/01/2020.
//  Copyright © 2020 Studio Willebrands. All rights reserved.
//

import Foundation

class EyeInTheSkyDataManager {

    static let session = URLSession(configuration: .default)
    
    typealias PhotoCompletionHandler = (EyeInTheSkyPhoto?, Error?) -> Void
    
    static func fetchPhoto(lat: String, long: String, dim: String, completion: @escaping PhotoCompletionHandler) {
        let url = Endpoint.eyeInTheSky.url()
        print(url)
        
        fetchData(url: url) { (photoData, error) in
            guard let photo = photoData else {
                completion(nil, NetworkingError.invalidData)
                return
            }
            completion(photo, nil)
        }
    }

    static private func fetchData(url: URL, completion: @escaping PhotoCompletionHandler) {
        let request = URLRequest(url: url)

        let task = session.dataTask(with: request) { data, response, error in
                if let data = data {
                    guard let httpResponse = response as? HTTPURLResponse else {
                        completion(nil, NetworkingError.requestFailed)
                        return
                    }
                    if 200...299 ~= httpResponse.statusCode {
                        do {
                            let photo = try JSONDecoder.dataDecoder.decode(EyeInTheSkyPhoto.self, from: data)
                            completion(photo, nil)
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
