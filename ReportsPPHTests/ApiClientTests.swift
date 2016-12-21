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
        //empty the keychain with the test data
        let keychain = KeychainSwift()
        keychain.delete("userAuth")
        
        
        super.tearDown()
    }
    
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    /**
     Test ApiClient.instance.executeAccessTokenRequest
     ``` sh
     curl -X POST -H "Authorization: Basic aW9zOmlvc1NlY3JldA==" -H "Content-Type: application/x-www-form-urlencoded" -H "Cache-Control: no-cache" -d 'grant_type=password&username=bob&password=bobs_auth' "http://localhost:8080/ReportsWS/oauth/token"
     ```
    */
    func testApiClientExecuteAccessTokenRequest() {
        var running = true
        var accessGranted = false
        //Given
        DataService.instance.user?.tokenInfo?.access_token = "at"
        DataService.instance.user?.tokenInfo?.refresh_token = "rt"
        let username = "mike"
        let password = "mikes_auth"
        
        //when
        ApiClient.instance.executeAccessTokenRequest(username: username, password: password){
            (accessTokenReceived) in
            accessGranted = accessTokenReceived
            running = false
        }
        
        while running {
            print("waiting...")
            sleep(1)
        }
        
        //then
        XCTAssertTrue(accessGranted)
        print(DataService.instance.user?.tokenInfo?.refresh_token ?? "No refresh token")
        XCTAssertNotNil(DataService.instance.user?.tokenInfo)
        XCTAssertNotEqual(DataService.instance.user?.tokenInfo?.refresh_token, "rt")
        XCTAssertNotEqual(DataService.instance.user?.tokenInfo?.access_token, "at")
    }
    
    /**
     A HTTP GET example of request token through executeRequest method in ApiClient
    */
    func testReceiveAccessToken(){
        
        var running = true
        let username = "bob"
        let password = "bobs_auth"
        let url = "\(Config.instance.wsUrl!)/\(Config.instance.wsApi!)/\(Config.API_OAUTH_ENDPOINT)?grant_type=password&username=\(username)&password=\(password)"
        var accessToken:String?
        var refreshToken:String?
        
        ApiClient.instance.executeRequest(url: url, UtilsHelper.buildAuthorizationHeader, authType: "basic", userAuth: UserAuth()) {
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
