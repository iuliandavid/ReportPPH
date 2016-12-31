//
//  ApiClientTests.swift
//  ReportsPPH
//
//  Created by iulian david on 12/2/16.
//  Copyright © 2016 iulian david. All rights reserved.
//

import XCTest
@testable import ReportsPPH

/**
 Integration tests for ApiClient class
 Assumes one has a running webservice with oAuth2 authentication
 */
class ApiClientTests: XCTestCase, DataServiceInjected {
    
    let callBackDelay: TimeInterval = 5
    
    override func setUp() {
        super.setUp()
        InjectionMap.dataService = MockDataService()
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
        let expectationText = expectation(description: "Executing access token request")
        var accessGranted = false
        
        //Given
        dataService.user?.tokenInfo = TokenInfo()
        dataService.user?.tokenInfo?.access_token = "at"
        dataService.user?.tokenInfo?.refresh_token = "rt"
        let username = "mike"
        let password = "mikes_auth"
        
        //when
        ApiClient.instance.executeAccessTokenRequest(username: username, password: password){
            (result) in
            switch (result) {
            case .Success(let accessToken) :
                accessGranted = true
                guard let token = accessToken as? TokenInfo
                    else {
                        self.dataService.user?.tokenInfo = nil
                        break
                }
                self.dataService.user?.tokenInfo?.access_token = token.access_token
                self.dataService.user?.tokenInfo?.refresh_token = token.refresh_token
                break;
                
            case .Failure(let err):
                print(err)
                break;
            }
            expectationText.fulfill()
        }
        
        waitForExpectations(timeout: callBackDelay) { error in
            
            XCTAssertNil(error, "Something went horribly wrong")
            print(error.debugDescription)
            
        }
        
        //then
        XCTAssertTrue(accessGranted)
        print(dataService.user?.tokenInfo?.refresh_token ?? "No refresh token")
        XCTAssertNotNil(dataService.user?.tokenInfo)
        XCTAssertNotEqual(dataService.user?.tokenInfo?.refresh_token, "rt")
        XCTAssertNotEqual(dataService.user?.tokenInfo?.access_token, "at")
    }
    
    /**
     A HTTP GET example of request token through executeRequest method in ApiClient
    */
    func testReceiveAccessToken(){
        
        let expectationText = expectation(description: "Executing access token request")
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
            expectationText.fulfill()
        }
        
       
        waitForExpectations(timeout: callBackDelay) { error in
            
            XCTAssertNil(error, "Something went horribly wrong")
            print(error.debugDescription)
            
        }

        XCTAssertNotNil(accessToken)
        XCTAssertNotNil(refreshToken)
    }
    
    func testIncorrectUrlShouldGetAnError(){
        let expectationText = expectation(description: "Executing access token request")
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
            expectationText.fulfill()
        }
        
        waitForExpectations(timeout: callBackDelay) { error in
            
            XCTAssertNil(error, "Something went horribly wrong")
            print(error.debugDescription)
            
        }
        
        XCTAssert(errorNotNill)
    }
    
}
