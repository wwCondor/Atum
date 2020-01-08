//
//  EyeInTheSkyDataManager.swift
//  Atum
//
//  Created by Wouter Willebrands on 02/01/2020.
//  Copyright © 2020 Studio Willebrands. All rights reserved.
//

import Foundation

class EyeInTheSkyDataManager {
    
    typealias PhotoCompletionHandler = (EyeInTheSkyPhoto?, Error?) -> Void
    
    static func getPhoto(lat: String, long: String, dim: String, completion: @escaping PhotoCompletionHandler) {
        let url = Endpoint.eyeInTheSky.url()
        print("Sky-Eye photo retrieval URL: \(url)")
        
        Networker.request(url: url) { (result) in
            switch result {
            case .success(let data):
                guard let photos = try? JSONDecoder.dataDecoder.decode(EyeInTheSkyPhoto.self, from: data) else { return }
                completion(photos, nil)
            case .failure(let error):
                completion(nil, error)
            }
        }
    }
}
