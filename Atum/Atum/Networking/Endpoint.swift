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

enum Endpoint {
    case marsRover  // Mars Rover API
    case eyeInTheSky // Earth (Eye in the Sky) API
    case blueMarbleDates // DSCOVR's Earth Polychromatic Imaging Camera (EPIC)
    
    case blueMarbleImages
    
    private var baseURL: URL {
        return URL(string: "https://api.nasa.gov/")! // Eye in the sky
    }
    
    func url() -> URL {
        // Mars Rover Query
        let camera: String = MarsRoverQueryData.userRoverDataSelections.selectedRoverCamera.abbreviation // Default: FHAZ
        let dateSelected: String = MarsRoverQueryData.userRoverDataSelections.selectedRoverPhotoDate     // Default: Landing Date
        
        let longitude: String = SkyEyeQueryData.userEyeDataSelections.selectedLocation.longitude         // Default: Mount Everest
        let latitude: String = SkyEyeQueryData.userEyeDataSelections.selectedLocation.latitude
        let zoom: String = SkyEyeQueryData.userEyeDataSelections.selectedZoomLevel
        
        let naturalDateSelected: String = BlueMarbleQueryData.userBlueMarbleDataSelection.selectedDate
        
        switch self {
        case .marsRover:
            var components = URLComponents(url: baseURL.appendingPathComponent("mars-photos/api/v1/rovers/curiosity/photos"), resolvingAgainstBaseURL: false)
            components?.queryItems = [
                URLQueryItem(name: "earth_date", value: "\(dateSelected)"),
                URLQueryItem(name: "camera",     value: "\(camera)"), 
                URLQueryItem(name: "api_key",    value: "\(APIKey.key)"),
            ]
            return components!.url!
        case .eyeInTheSky:
            var components = URLComponents(url: baseURL.appendingPathComponent("planetary/earth/imagery/"), resolvingAgainstBaseURL: false)
            components?.queryItems = [
                URLQueryItem(name: "lat",     value: "\(latitude)"),
                URLQueryItem(name: "lon",     value: "\(longitude)"),
                URLQueryItem(name: "dim",     value: "\(zoom)"),
                URLQueryItem(name: "api_key", value: "\(APIKey.key)"),
            ]
            return components!.url!
        case .blueMarbleDates:
            var components = URLComponents(url: baseURL.appendingPathComponent("EPIC/api/natural/all"), resolvingAgainstBaseURL: false)
            components?.queryItems = [
                URLQueryItem(name: "api_key",   value: "\(APIKey.key)"),
            ]
            return components!.url!
        case .blueMarbleImages:
            var components = URLComponents(url: baseURL.appendingPathComponent("EPIC/api/natural/date/\(naturalDateSelected)"), resolvingAgainstBaseURL: false)
            components?.queryItems = [
                URLQueryItem(name: "api_key",   value: "\(APIKey.key)"),
            ]
            return components!.url!
        }
    }
}
/*
 https://api.nasa.gov/EPIC/api/natural/all?api_key=DEMO_KEY
 https://api.nasa.gov/EPIC/api/natural/all?api_key=MKjkqRBKMSLQxBfCIUFcFUxhVjhK3Q3m3HnXVB3w
 https://api.nasa.gov/planetary/earth/imagery/?lat=-27.1127&lon=-109.3497&dim=0.1&api_key=MKjkqRBKMSLQxBfCIUFcFUxhVjhK3Q3m3HnXVB3w
 
 
 */
/*
 
 https://api.nasa.gov/planetary/earth/imagery?lon=100.75&lat=1.5&api_key=MKjkqRBKMSLQxBfCIUFcFUxhVjhK3Q3m3HnXVB3w
 https://api.nasa.gov/planetary/earth/imagery?lat=1.5&lon=100.75&dim=0.8&api_key=MKjkqRBKMSLQxBfCIUFcFUxhVjhK3Q3m3HnXVB3w
 https://api.nasa.gov/planetary/earth/imagery/?lat=1.5&lon=100.75&dim=0.8&api_key=MKjkqRBKMSLQxBfCIUFcFUxhVjhK3Q3m3HnXVB3w"
 
 https://earthengine.googleapis.com/api/thumb?thumbid=676404ea91829b1ab267b9863975ba80&token=33db54cb12fd152eec6d7c625ca9d74e
 
 */

/*
https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?earth_date=2015-08-03&camera=navcam&api_key=DEMO_KEY
https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?earth_date=2012-08-07&camera=FHAZ&api_key=MKjkqRBKMSLQxBfCIUFcFUxhVjhK3Q3m3HnXVB3w
 
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
