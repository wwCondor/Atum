//
//  Error.swift
//  Atum
//
//  Created by Wouter Willebrands on 24/12/2019.
//  Copyright © 2019 Studio Willebrands. All rights reserved.
//

import Foundation

enum NetworkingError: Error {
    case requestFailed
    case jsonConversionFailure
    case invalidData
    case noData
    case responseUnsuccessful
    case jsonParsingFailure
    case jsonDecodingFailure
    case invalidUrl
    case missingKey
    case noReachability
}

extension NetworkingError: LocalizedError {
    public var localizedDescription: String {
        switch self {
        case .requestFailed:         return "Request Failed"
        case .invalidData:           return "Invalid Data"
        case .noData:                return "No Data"
        case .responseUnsuccessful:  return "Response Unsuccessful"
        case .jsonParsingFailure:    return "JSON Parsing Failure"
        case .jsonConversionFailure: return "JSON Conversion Failure"
        case .jsonDecodingFailure:   return "JSON Decoding Failure"
        case .invalidUrl:            return "Invalid URL"
        case .missingKey:            return "Please set your key in APIkey.swift"
        case .noReachability:        return "Check connection and try again"
        }
    }
}
