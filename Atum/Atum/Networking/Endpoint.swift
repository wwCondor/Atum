//
//  Endpoint.swift
//  Atum
//
//  Created by Wouter Willebrands on 24/12/2019.
//  Copyright © 2019 Studio Willebrands. All rights reserved.
//

import Foundation

struct APIKey {
    static let key: String = "MKjkqRBKMSLQxBfCIUFcFUxhVjhK3Q3m3HnXVB3w"
}

//struct RoverPhotoSearch {
//    var rover: String
//    var camera: String
//    var sol: Int
//
//    static var roverPhotoSearch = RoverPhotoSearch(rover: Rover.opportunity.name, camera: RoverCamera.navcam.abbreviation, sol: 1)
//}

enum Endpoint {
    case marsRover
    //    case earthImagery
    case blueMarbleDates // DSCOVR's Earth Polychromatic Imaging Camera (EPIC)
    case blueMarbleImages
    
    private var baseURL: URL {
        return URL(string: "https://api.nasa.gov/")! // Eye in the sky
    }
    
    func url() -> URL {
        let rover = Rover.curiosity.name
        let camera = RoverCamera.navcam.abbreviation
//        let sol = 1
        
        let dateSelected: String = "2019-06-23"
         
        switch self {
        case .marsRover:
            var components = URLComponents(url: baseURL.appendingPathComponent("mars-photos/api/v1/rovers/\(rover)/photos"), resolvingAgainstBaseURL: false)
            components?.queryItems = [
//                URLQueryItem(name: "sol",        value: "\(sol)"),
                URLQueryItem(name: "earth_date", value: "\(dateSelected)"),
                URLQueryItem(name: "camera",     value: "\(camera)"), // defaulted to all
                URLQueryItem(name: "api_key",    value: "\(APIKey.key)"),
            ]
            return components!.url!
        case .blueMarbleDates:
            var components = URLComponents(url: baseURL.appendingPathComponent("EPIC/api/natural/all"), resolvingAgainstBaseURL: false)
            components?.queryItems = [
                URLQueryItem(name: "api_key",   value: "\(APIKey.key)"),
            ]
            return components!.url!
        case .blueMarbleImages:
            var components = URLComponents(url: baseURL.appendingPathComponent("EPIC/api/natural/date/\(dateSelected)"), resolvingAgainstBaseURL: false)
            components?.queryItems = [
                URLQueryItem(name: "api_key",   value: "\(APIKey.key)"),
            ]
            return components!.url!
        }
    }
}

/*
 - make api call for available dates
 - save sated into array
 - create picker
 - populate picker with dates
 - use selected picker date to make api call for image(s) string
 - use image string to make api for images
 - present images

 
https://api.nasa.gov/EPIC/api/natural/images?api_key=DEMO_KEY
https://api.nasa.gov/EPIC/api/natural/date/2015-10-31?api_key=DEMO_KEY natural/date
 
https://api.nasa.gov/EPIC/api/natural/all?api_key=DEMO_KEY // Provides all dates available
*/





/*
 https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?earth_date=2015-6-3&api_key=DEMO_KEY
 
 Example request for marsRover:
 https://api.nasa.gov/mars-photos/api/v1/rovers/ // Base for rover images
 https://api.nasa.gov/mars-photos/api/v1/rovers/
 Opportunity/photos?
 sol=1&
 camera=NAVCAM&
 api_key=MKjkqRBKMSLQxBfCIUFcFUxhVjhK3Q3m3HnXVB3w
 
 https://api.nasa.gov/mars-photos/api/v1/rovers/Opportunity/photos?sol=1&camera=NAVCAM&api_key=MKjkqRBKMSLQxBfCIUFcFUxhVjhK3Q3m3HnXVB3w

 
 https://api.nasa.gov/mars-photos/api/v1/?rovers=Opportunity/photos?&sol=1
 
 https://api.nasa.gov/mars-photos/api/v1/rovers/Opportunity/photos?sol=1
 
 Rovers: curiosity, opportunity, spirit
 
 Query parameters
 - sol: Int (sol - ranges from 0 to max found in endpoint) // Sol: Martian day
 - camera: String                                       - default is all
 - page: Int (25 item per page)                         - default is 1
 - api_key: String
 
 Response:
 
 - photos: []
    - id: Int
    - sol: Int
    - camera: {}
        - id: Int
        - name: String
        - rover_id: Int
        - full_name: String
    - img_src: String (http)
    - earth_date: String
    - rover: {}
        - name: String
        - landing_date: String
        - launch_date: String
        - status: String
        - max_sol: Int
        - max_date: String
        - total_photos: Int
        - cameras: []
                - name: String
                - full_name: String
 
 */


/*
https://api.nasa.gov/planetary/apod?api_key=MKjkqRBKMSLQxBfCIUFcFUxhVjhK3Q3m3HnXVB3w
Example request for earthImagery:
https://api.nasa.gov/planetary/earth/imagery?lon=100.75&lat=1.5&date=2014-02-01&cloud_score=True&api_key=DEMO_KEY

Query parameters
- lat: Float (Latitude)
- lon: Float (Longitude)
- dim: Float (width and heighht of image in degrees)   - default is 0.025
- date: YYYY-MM-DD                                     - default is today
- cloud_score: Bool (% image covered by clouds)        - default false
- api_key: String

Response:

- cloud_score: Int                 // 0.03926652301686606
- date: String                     // 2014-02-04T03:30:01
- id: String                       // LC8_L1T_TOA/LC81270592014035LGN00
- resource: {}
       - dataset: String           // LC8_L1T_TOA
       - planet: String            // earth
service_version: String            // v1
url: String                        // http:...
*/
