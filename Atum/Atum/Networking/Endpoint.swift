//
//  Endpoint.swift
//  Atum
//
//  Created by Wouter Willebrands on 24/12/2019.
//  Copyright © 2019 Studio Willebrands. All rights reserved.
//

import Foundation

enum Endpoint {
    case earthImagery
    case marsRover
//    case manifest
    
    
    private var baseURL: URL {
        return URL(string: "https://api.nasa.gov/")! // Eye in the sky
    }
}


/*
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

/*
 Example request for marsRover:
https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?sol=1000&camera=fhaz&api_key=DEMO_KEY
 
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
