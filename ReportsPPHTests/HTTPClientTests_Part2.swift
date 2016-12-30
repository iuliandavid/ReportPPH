//
//  HTTPClientTests_Part2.swift
//  ReportsPPH
//
//  Created by iulian david on 12/29/16.
//  Copyright © 2016 iulian david. All rights reserved.
//

import XCTest
@testable import ReportsPPH


class HTTPClientTests_Part2: XCTestCase {
    var subject: HTTPClient!
    let session = MockURLSession()
    
    override func setUp() {
        super.setUp()
        subject = HTTPClient(session: session)
    }
    
    func test_GET_WithResponseData_ReturnsTheData() {
        let expectedData = "{}".data(using: String.Encoding.utf8) 
        session.nextData = expectedData
        
        let expectationVar = expectation(description: "Wait for url to load.")
        let url = URLRequest(url: NSURL(string: "")! as URL,
                             cachePolicy: .useProtocolCachePolicy,
                             timeoutInterval: 0.0)
        
        var actualData: Data?
        subject.get(url: url as URLRequest) { (data, _) -> Void in
            actualData = data
            expectationVar.fulfill()
        }
        
        waitForExpectations(timeout: 25) { error in
            
            XCTAssertNil(error, "Something went horribly wrong")
            print(error.debugDescription)
            
        }
        XCTAssertEqual(actualData, expectedData)
    }
    
}
