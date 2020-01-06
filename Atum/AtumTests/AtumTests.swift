//
//  AtumTests.swift
//  AtumTests
//
//  Created by Wouter Willebrands on 24/12/2019.
//  Copyright © 2019 Studio Willebrands. All rights reserved.
//

import XCTest
@testable import Atum

class AtumTests: XCTestCase {
    
    var session: URLSession!

    override func setUp() {
        super.setUp()
        session = URLSession(configuration: .default)
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        session = nil
        super.tearDown()
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    // MARK: URL Tests
    func testRoverPhotoUrl() {
        let roverCamera: RoverCamera = .fhaz
        MarsRoverQueryData.userRoverDataSelections.selectedRoverCamera = roverCamera
        MarsRoverQueryData.userRoverDataSelections.selectedRoverPhotoDate = PlaceHolderText.roverInitialDate
        let endpoint = Endpoint.marsRover.url()
        let expectedURL = URL(string: "https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?earth_date=2015-08-06&camera=FHAZ&api_key=\(APIKey.key)")
        XCTAssertEqual(endpoint, expectedURL)
    }
    
    func testSkyEyePhotoUrl() {
        let location: Location = .mountEverest
        SkyEyeQueryData.userEyeDataSelections.selectedLocation = location
        SkyEyeQueryData.userEyeDataSelections.selectedZoomLevel = PlaceHolderText.initalZoomLevel
        let endpoint = Endpoint.eyeInTheSky.url()
        let expectedURL = URL(string: "https://api.nasa.gov/planetary/earth/imagery/?lat=27.9881&lon=86.9250&dim=0.05&api_key=\(APIKey.key)")
        XCTAssertEqual(endpoint, expectedURL)
    }
    
    func testNaturalDatesUrl() {
        let endpoint = Endpoint.blueMarbleDates.url()
        let expectedURL = URL(string: "https://api.nasa.gov/EPIC/api/natural/all?api_key=\(APIKey.key)")
        XCTAssertEqual(endpoint, expectedURL)
    }
    
    func testBlueMarblePhotosUrl() {
        let endpoint = Endpoint.blueMarbleImages.url()
        let expectedURL = URL(string: "https://api.nasa.gov/EPIC/api/natural/date/2019-06-27?api_key=\(APIKey.key)")
        XCTAssertEqual(endpoint, expectedURL)
    }
    
    func testBlueMarblePhotoUrl() {
        let fullDate: String = "2019-06-27"
        let fullDateArray: [String] = fullDate.components(separatedBy: "-")
        let year: String = fullDateArray[0]
        let month: String = fullDateArray[1]
        let day: String = fullDateArray[2]
        let imageBaseURl: String = "https://epic.gsfc.nasa.gov/archive/natural/"
        let imageName: String = "epic_1b_20190627011358"
        let url = URL(string: "\(imageBaseURl)\(year)/\(month)/\(day)/jpg/\(imageName).jpg")!
        let expectedURL = URL(string: "https://epic.gsfc.nasa.gov/archive/natural/2019/06/27/jpg/epic_1b_20190627011358.jpg")
        XCTAssertEqual(url, expectedURL)
    }
    
    // MARK: Status Code Test
    func testStatusResponseCode() {
        let expectation = self.expectation(description: "Status OK")
        let testUrl = URL(string: "https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?earth_date=2015-08-06&camera=FHAZ&api_key=\(APIKey.key)")!
        var statusCode: Int?
        var responseError: Error?
        
        _ = session.dataTask(with: testUrl) { data, response, error in
            statusCode = (response as? HTTPURLResponse)?.statusCode
            responseError = error
            expectation.fulfill()
        }.resume()
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertNil(responseError, "Status code != 200")
        XCTAssertEqual(statusCode, 200)
    }
    
    // MARK: Parsing Tests
    // In here we should test the differt API calls and test whether data contains images
    // If response does not contain images, test wether we don't crash
    func testRetrievingRoverPhotoForData() {
        let expectation = self.expectation(description: "allPhotos.count =! 0")
        var responseError: Error?
        var allPhotos: [RoverPhoto]?
        let date: String = "2015-08-06"
        let camera: RoverCamera = .fhaz
        MarsRoverDataManager.fetchPhotos(date: date, camera: camera.abbreviation) { (photoData, error) in
            guard let photos = photoData else {
                responseError = error
                return
            }
            allPhotos = photos
            expectation.fulfill()
        }
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertNil(responseError, "Error")
        XCTAssertNotNil(allPhotos)
    }
    
    func testRetrievingSkyEyePhotoData() {
        let expectation = self.expectation(description: "retrievedPhoto =! nil")
        var responseError: Error?
        var retrievedPhoto: EyeInTheSkyPhoto?
        let location: Location = .mountEverest
        let dim = "0.1"
        EyeInTheSkyDataManager.fetchPhoto(lat: location.latitude, long: location.longitude, dim: dim) { (photoData, error) in
            guard let photo = photoData else {
                responseError = error
                return
            }
            retrievedPhoto = photo
            expectation.fulfill()
        }
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertNil(responseError, "Error")
        XCTAssertNotNil(retrievedPhoto)
    }
    
    func testNaturalDatesRetrieval() {
        let expectation = self.expectation(description: "allDates.count =! 0")
        var responseError: Error?
        var allDates: [BlueMarbleDate]?
        BlueMarbleDataManager.fetchDates { (data, error) in
            guard let dates = data else {
                responseError = error
                return
            }
            allDates = dates
            expectation.fulfill()
        }
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertNil(responseError, "Error")
        XCTAssertNotNil(allDates)
    }
    
    func testRetrievingEPICPhotoData() {
        let expectation = self.expectation(description: "allPotosData.count =! 0")
        var responseError: Error?
        let date: String = "2019-06-27"
        var allPotosData: [BlueMarblePhoto]?
        BlueMarbleDataManager.fetchPhotos(date: date) { (photoData, error) in
            guard let photos = photoData else {
                responseError = error
                return
            }
            allPotosData = photos
            expectation.fulfill()
        }
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertNil(responseError, "Error")
        XCTAssertNotNil(allPotosData)
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
}
