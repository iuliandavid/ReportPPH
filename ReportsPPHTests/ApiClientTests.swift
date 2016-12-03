//
//  ApiClientTests.swift
//  ReportsPPH
//
//  Created by iulian david on 12/2/16.
//  Copyright © 2016 iulian david. All rights reserved.
//

import XCTest
@testable import ReportsPPH


class ApiClientTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testReceiveAccessToken(){
        
        var running = true
        let url = "http://localhost:8080/ReportsWS/oauth/token?grant_type=password&username=bob&password=bobs_auth"
        var accessToken:String?
        var refreshToken:String?
        
        ApiClient.instance.executeRequest(url: url, UtilsHelper.buildAuthorizationHeader, authType: "basic", userAuth: UserAuth()){
            (statusCode, data, error) in
            if let err = error {
                print(err)
            } else {
                let httpResponse = data as! [String: AnyObject]
                print(httpResponse)
                accessToken = httpResponse["access_token"] as? String
                refreshToken = httpResponse["refresh_token"] as? String
                
            }
            running = false
        }
        
        while running {
            print("waiting...")
            sleep(1)
        }
        
        XCTAssertNotNil(accessToken)
        XCTAssertNotNil(refreshToken)
    }
    
    func testIncorrectUrlShouldGetAnError(){
        var running = true
        let url = "http://localhost:8081/ReportsWS/oauth/token?grant_type=password&username=bob&password=bobs_auth"
        var errorNotNill: Bool = false
        
        ApiClient.instance.executeRequest(url: url, UtilsHelper.buildAuthorizationHeader, authType: "basic", userAuth: UserAuth()){
            (statusCode, data, error) in
            if let err = error {
                print(err)
                errorNotNill = true
            } else {
                let httpResponse = data as! [String: AnyObject]
                print(httpResponse)
            }
            running = false
        }
        
        while running {
            print("waiting...")
            sleep(1)
        }
        
        XCTAssert(errorNotNill)
    }
    
    
    
}
