//
//  SwiftRestTests.swift
//  SwiftRestTests
//
//  Created by Bacem Ben Afia on 13/05/2019.
//  Copyright © 2019 Bacem Ben Afia, A.K.A Pirana. ba.bessem@gmail.com ios/android/jee. All rights reserved.
//

import XCTest
@testable import SwiftRest

class SwiftRestTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testNearEarthListService() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let expectation = XCTestExpectation(description: "nearEarthObjects exist")
        
        NearEarthListService.shared.ping(completion: { (result) in
            switch result{
            case .success(_):
                do {
                    let count = try result.get().nearEarthObjects.count
                    XCTAssert( count > 0)
                }
                catch {
                    XCTFail()
                }
            case .failure(_):
                XCTFail()
            }
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: 5.0)
        
    }
    
    func testNearEarthObject() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let neo = NearEarthObject(id: "1", neoReferenceID: "@", name: "neo", nasaJplURL: "neourl", absoluteMagnitudeH: 0.0, isPotentiallyHazardousAsteroid: true, isSentryObject: true)
        
        assert(neo.hazardColor == UIColor(red: 190/255, green: 10/255, blue: 50/255, alpha: 1), "green color")

    }

}
