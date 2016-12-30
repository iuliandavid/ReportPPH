//
//  HTTPClient_Integration.swift
//  ReportsPPH
//
//  Created by iulian david on 12/29/16.
//  Copyright © 2016 iulian david. All rights reserved.
//

import XCTest
@testable import ReportsPPH

/**
 Integration test for HTTPClient
 Test if we get some data from the internet
 - Remark:
    This test uses [JSONPLACEHOLDER](https://jsonplaceholder.typicode.com/)
 */
class HTTPClientTests_Integration: XCTestCase {
    
    var subject: HTTPClient!
    
    let callBackDelay: TimeInterval = 5

    let INTEGRATION_TEST_URL = "https://jsonplaceholder.typicode.com/posts/1"
    
    override func setUp(){
        super.setUp()
        subject = HTTPClient()
    }
    
    /**
     
     So we use expectations
     
     1. Set up an "expectation" telling Xcode that it should start waiting.
     2. When our asynchronous code returns we inform the test runner that all is well and no more waiting needs to occur.
     3. Let Xcode know how long it should wait before failing.
     */
    
    func test_GET_ReturnsData() {
       let url = URL(string: INTEGRATION_TEST_URL)!
        let expectationVar = expectation(description: "Wait for \(url) to load.")
        let urlRequest = URLRequest(url: url)

        var data: Any?
        subject.executeRequest(url: urlRequest) { (_ , theData, error) -> Void in
            data = theData
            expectationVar.fulfill()
        }
        waitForExpectations(timeout: callBackDelay) { error in
                
                XCTAssertNil(error, "Something went horribly wrong")
               print(error.debugDescription)
                
            }
            
        
        XCTAssertNotNil(data)
    }
    
    

    
    
}
