//
//  Networker.swift
//  Atum
//
//  Created by Wouter Willebrands on 08/01/2020.
//  Copyright © 2020 Studio Willebrands. All rights reserved.
//

import Foundation

class Networker {
    static func request(url: URL, completion: @escaping (Result<Data, Error>) -> Void) {
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let data = data {
                completion(.success(data))
            } else if let error = error {
                completion(.failure(error))
            }
        }.resume()
    }
}
