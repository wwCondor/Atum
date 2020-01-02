//
//  BlueMarbleDataManager.swift
//  Atum
//
//  Created by Wouter Willebrands on 30/12/2019.
//  Copyright © 2019 Studio Willebrands. All rights reserved.
//

import Foundation

class BlueMarbleDataManager {
//    static let decoder: JSONDecoder = {
//        let decoder = JSONDecoder()
//        decoder.keyDecodingStrategy = .convertFromSnakeCase
//        return decoder
//    }()

    static let session = URLSession(configuration: .default)
    
//    typealias GenresCompletionHandler = (Genres?, Error?)-> Void
//    typealias GenreItemsCompletionHandler = ([Genre]?, Error?) -> Void
//
//    static func fetchGenres(completion: @escaping GenreItemsCompletionHandler) {
//        var allGenres = [Genre]()
//        getGenres { (genreObject, error) in
//            guard let genres = genreObject?.genres else {
//                completion(nil, MovieDBError.noResults)
//                return
//            }
//            for genre in genres {
//                allGenres.append(genre)
//            }
//            completion(allGenres, nil)
//        }
//    }
    
    static func getDates(completion: @escaping ([BlueMarbleDate]?, Error?) -> Void) {
        let url = Endpoint.blueMarbleDates.url()
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


