//
//  HTTPClientTests.swift
//  ReportsPPH
//
//  Created by iulian david on 12/29/16.
//  Copyright © 2016 iulian david. All rights reserved.
//

import XCTest
@testable import ReportsPPH

class HTTPClientTests_Part1: XCTestCase {
    var subject: HTTPClient!
    let session = MockURLSession()
    
    let EMPTY_URL = "http://localhost"
    
    override func setUp() {
        super.setUp()
        subject = HTTPClient(session: session)
    }
    
    func test_GET_RequestsTheURL() {
        let url = URLRequest(url: URL(string: EMPTY_URL)!)
        subject.executeRequest(url: url as URLRequest) { (_,_, _) -> Void in }
        
        XCTAssert(session.lastURL == url.url)
    }
    
    func test_GET_StartsTheRequest() {
        let dataTask = MockURLSessionDataTask()
        guard let url = URL(string: EMPTY_URL) else {
            XCTFail()
            return
        }
        let request = URLRequest(url: url)
        session.nextDataTask = dataTask
        subject.executeRequest(url: request) { (_,_, _) -> Void in }
        
        XCTAssert(dataTask.resumeWasCalled)
    }
    
    
}
