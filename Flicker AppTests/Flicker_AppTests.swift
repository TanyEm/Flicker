//
//  Flicker_AppTests.swift
//  Flicker AppTests
//
//  Created by Tatiana Podlesnykh on 16.2.2021.
//

import XCTest
@testable import Flicker_App

class Flicker_AppTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testRequest() throws {
        let searchRequest = NetworkManager()
                
        let expectation = self.expectation(description: "photoList")
        var isReceived: Bool?
        
        searchRequest.getPhotosList(search: "Apple") { (result) in
            if result.photo.count != 0 {
                isReceived = true
            } else {
                isReceived = false
            }
            expectation.fulfill()
        }
        waitForExpectations(timeout: 10, handler: nil)

        print("isReceived",isReceived)
        XCTAssertEqual(isReceived, true)
        
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
