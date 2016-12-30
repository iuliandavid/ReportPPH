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
    
    override func setUp() {
        super.setUp()
        subject = HTTPClient(session: session)
    }
    
    func test_GET_RequestsTheURL() {
        
        let url = NSMutableURLRequest(url: NSURL(string: "http://google.com")! as URL,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10.0)
        subject.get(url: url as URLRequest) { (_, _) -> Void in }
        
        XCTAssert(session.lastURL == url.url)
    }
    
    func test_GET_StartsTheRequest() {
        let dataTask = MockURLSessionDataTask()
        let address = "https://www.random.org/dice/?num=2"
        guard let url = URL(string: address) else {
            XCTFail()
            return
        }
        let request = URLRequest(url: url)
        session.nextDataTask = dataTask
        subject.get(url: request) { (_, _) -> Void in }
        
        XCTAssert(dataTask.resumeWasCalled)
    }
    
    
}
