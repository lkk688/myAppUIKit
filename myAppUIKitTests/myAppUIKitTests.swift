//
//  myAppUIKitTests.swift
//  myAppUIKitTests
//
//  Created by Kaikai Liu on 1/31/21.
//

import XCTest
@testable import myAppUIKit

class myAppUIKitTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testDataModelInitializationSucceeds() {
        let zeroRating = NewsData.init(identifier: 1, title: "testing", name: "me", story: "test the story", photo: "Image1", rating: 3, weblink: URL(string: "www.google.com"), coordinate: nil)
        XCTAssertNotNil(zeroRating)
    }
    
    func testDataModelInitializationFails() {
        let negativeRating = NewsData.init(identifier: 1, title: "testing", name: "me", story: "test the story", photo: "Image1", rating: -1, weblink: URL(string: "www.google.com"), coordinate: nil)
        XCTAssertNil(negativeRating)
        
        // Empty title String
        let emptyString = NewsData.init(identifier: 1, title: "", name: "me", story: "test the story", photo: "Image1", rating: -1, weblink: URL(string: "www.google.com"), coordinate: nil)
        XCTAssertNil(emptyString)
    }
    
}
