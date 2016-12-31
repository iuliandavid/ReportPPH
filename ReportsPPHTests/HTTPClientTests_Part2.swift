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
    var httpClient: HTTPClient!
    let session = MockURLSession()
    
    let EMPTY_URL = "http://localhost"
    
    override func setUp() {
        super.setUp()
        httpClient = HTTPClient(session: session)
    }
    
    func test_GET_WithResponseData_ReturnsTheData() {
        let expectedData = "{}".data(using: String.Encoding.utf8)
        session.nextData = expectedData
        
        let expectationVar = expectation(description: "Wait for url to load.")
        let url = URLRequest(url: NSURL(string: "")! as URL,
                             cachePolicy: .useProtocolCachePolicy,
                             timeoutInterval: 0.0)
        
        var actualData: Data?
        httpClient.executeRequest(url: url as URLRequest) { (_, data, _) -> Void in
            do {
            let jsonData = try JSONSerialization.data(withJSONObject: data ?? "")
                actualData = jsonData
            } catch {
                XCTFail()
            }
            
            expectationVar.fulfill()
        }
        
        waitForExpectations(timeout: 25) { error in
            
            XCTAssertNil(error, "Something went horribly wrong")
            print(error.debugDescription)
            
        }
        XCTAssertEqual(actualData, expectedData)
    }
    
    func test_GET_WithANetworkError_ReturnsANetworkError() {
        session.nextError = NSError(domain: "error", code: 0, userInfo: nil)
        
        var error: MyError?
        httpClient.executeRequest(url: URLRequest(url: URL(string: EMPTY_URL)!)) { (_,_, theError) -> Void in
            error = theError
        }
        guard let _ = error else {
            XCTFail("Nil error")
            return
        }
        XCTAssertTrue(MyError.NetworkError == error!)
    }
}
