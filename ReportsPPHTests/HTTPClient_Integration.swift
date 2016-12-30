//
//  HTTPClient_Integration.swift
//  ReportsPPH
//
//  Created by iulian david on 12/29/16.
//  Copyright © 2016 iulian david. All rights reserved.
//

import XCTest
@testable import ReportsPPH

class HTTPClientTests_Integration: XCTestCase {
    
    var subject: HTTPClient!
    
    let callBackDelay: TimeInterval = 2

    
    override func setUp(){
        super.setUp()
        subject = HTTPClient(session: URLSession.shared)
    }
    
    /**
     Test if we get some data from the internet
     So we use expectations
     
     1. Set up an "expectation" telling Xcode that it should start waiting.
     2. When our asynchronous code returns we inform the test runner that all is well and no more waiting needs to occur.
     3. Let Xcode know how long it should wait before failing.
     */
    
    func test_GET_ReturnsData() {
       let url = URL(string: "https://jsonplaceholder.typicode.com/posts/1")!
        let expectationVar = expectation(description: "Wait for \(url) to load.")
        var data: Data?
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")
        subject.get(url: urlRequest) { (theData, error) -> Void in
            data = theData
            expectationVar.fulfill()
        }
        waitForExpectations(timeout: 25) { error in
                
                XCTAssertNil(error, "Something went horribly wrong")
               print(error.debugDescription)
                
            }
            
        
        XCTAssertNotNil(data)
    }
    
    

    
    func testAsynchronousURLConnection() {
        let url = URL(string: "https://jsonplaceholder.typicode.com/posts/1")!
        let exp = expectation(description: "Async request")
        
        var urlRequest = URLRequest(url: url)
        
        urlRequest.httpMethod = "GET"
        urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            XCTAssertNotNil(data, "data should not be nil")
            XCTAssertNil(error, "error should be nil")
            exp.fulfill()
        }
        
        task.resume()
        
        waitForExpectations(timeout: 30) { error in
            if let error = error {
                print("Error: \(error)")
            }
        }
    }
}
