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
    
    let EMPTY_URL = URL(string: "http://empty_url")!
    
    override func setUp() {
        super.setUp()
        httpClient = HTTPClient(session: session)
    }
    
    /**
     # Testing Returned Data
     - Remark:
        Assume that the request is succesfull 
        ````
        let statusCode:Int? = 200
        ````
    */
    func test_GET_WithResponseData_ReturnsTheData() {
        //Given
        let expectedData = "{}".data(using: String.Encoding.utf8)
        session.nextData = expectedData
        let statusCode:Int? = 200
        session.nextResponse = HTTPURLResponse(statusCode: statusCode!)

        let expectationVar = expectation(description: "Wait for url to load.")
        let url = URLRequest(url: EMPTY_URL,
                             cachePolicy: .useProtocolCachePolicy,
                             timeoutInterval: 0.0)
        
        var actualData: Data?
        
        //when
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
        
        //THEN
        XCTAssertEqual(actualData, expectedData)
    }
    
    /**
     # Testing Network Error
     - Remark:
     Defining the error
     ````
     session.nextError = NSError(domain: "error", code: 0, userInfo: nil)
     ````
     */
    func test_GET_WithANetworkError_ReturnsANetworkError() {
        session.nextError = NSError(domain: "error", code: 0, userInfo: nil)
        
        var error: MyError?
        httpClient.executeRequest(url: URLRequest(url: EMPTY_URL)) { (_,_, theError) -> Void in
            error = theError
        }
        guard let _ = error else {
            XCTFail("Nil error")
            return
        }
        XCTAssertEqual(MyError.NetworkError, error!)
    }
    
    /**
     # Testing HTTP Status Codes
     Assume that anything in the 200 range is valid; anything else we will return an error.
    */
    
    func test_GET_WithAStatusCodeLessThan200_ReturnsAnError() {
        //Given
        let statusCode:Int? = 199
        session.nextResponse = HTTPURLResponse(statusCode: statusCode!)
        let errorTest = MyError.UnhandledError("Unauthorized call:\(statusCode!)")
        var error: MyError?
        //when
        httpClient.executeRequest(url: URLRequest(url: EMPTY_URL)) { (_,_, theError) -> Void in
            error = theError
        }
        //then
        XCTAssertEqual(errorTest, error)
    }
    /**
     # Testing HTTP Status Codes
     Assume that anything in the 200 range is valid; anything else we will return an error.
     */
    
    func test_GET_WithAStatusCodeGreaterThan299_ReturnsAnError() {
        //given
        let statusCode:Int? = 300
        session.nextResponse = HTTPURLResponse(statusCode: statusCode!)
        
        let errorTest = MyError.UnhandledError("Unauthorized call:\(statusCode!)")
        
        var error: MyError?
        //when
        httpClient.executeRequest(url: URLRequest(url: EMPTY_URL)) { (_,_, theError) -> Void in
            error = theError
        }
        //then
        XCTAssertEqual(errorTest, error)
    }
}

/**
 Just an extension with convenince init for tests
 */
extension HTTPURLResponse {
    
    convenience init?(statusCode: Int) {
        self.init(url: URL(string: "http://empty_url")!, statusCode: statusCode,
                  httpVersion: nil, headerFields: nil)
    }
}
