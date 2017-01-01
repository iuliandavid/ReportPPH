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
 Tests for ApiClient class
 Assumes one has a running webservice with oAuth2 authentication
 - Remarks: 
    Can be tranformed into integration tests by running a local WebService with the address set up in Config_debug.plist
 */
class ApiClientTests: XCTestCase, DataServiceInjected, NetworkingApiInjected {
    
    let callBackDelay: TimeInterval = 5
    let session = MockURLSession()
    var httpClient:HTTPClient!
    
    var username = "user"
    var password = "password"
    
    ///Set to true if there is a running [WebService](http://localhost:8080/ReportsWS/)
    let IS_INTEGRATION = false
    
    override func setUp() {
        super.setUp()
        InjectionMap.dataService = MockDataService()
        if IS_INTEGRATION {
            username = "mike"
            password = "mikes_auth"
        } else {
            httpClient = HTTPClient(session: session)
            networking.httpClient = httpClient
        }
    }
    
    override func tearDown() {
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
     curl -X POST -H "Authorization: Basic aW9zOmlvc1NlY3JldA==" -H "Content-Type: application/x-www-form-urlencoded" -H "Cache-Control: no-cache" -d 'grant_type=password&username=user&password=pass' "http://localhost:8080/ReportsWS/oauth/token"
     ```
    */
    func testApiClientExecuteAccessTokenRequest() {
        let expectationText = expectation(description: "Executing access token request")
        var accessGranted = false
        
        //Given
        dataService.user?.tokenInfo = TokenInfo()
        dataService.user?.tokenInfo?.access_token = "at"
        dataService.user?.tokenInfo?.refresh_token = "rt"

        
        
        //Given
        
        let expectedData = "{\"access_token\": \"access_token\", \"refresh_token\": \"refresh_token\"} ".data(using: String.Encoding.utf8)
        session.nextData = expectedData
        let statusCode:Int? = 200
        session.nextResponse = HTTPURLResponse(statusCode: statusCode!)
        
        //when
       networking.executeAccessTokenRequest(username: username, password: password){
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
        
        let url = "\(Config.instance.wsUrl!)/\(Config.instance.wsApi!)\(Config.API_OAUTH_ENDPOINT)?grant_type=password&username=\(username)&password=\(password)"
        var accessToken:String?
        var refreshToken:String?
        
        //Given
        
        let expectedData = "{\"access_token\": \"access_token\", \"refresh_token\": \"refresh_token\"} ".data(using: String.Encoding.utf8)
        session.nextData = expectedData
        let statusCode:Int? = 200
        session.nextResponse = HTTPURLResponse(statusCode: statusCode!)
        
        
        //when
        networking.executeRequest(url: url, UtilsHelper.buildAuthorizationHeader, authType: "basic", userAuth: UserAuth()) {
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
    
    ///This test is only valid if it's done in an integration
    ///Overwise it will pass but no knowledge can be aquirred from it
    func testIncorrectUrlShouldGetAnError(){
        let expectationText = expectation(description: "Executing access token request")
        let url = "http://localhost:8081/ReportsWS/oauth/token?grant_type=password&username=\(username)&password=\(password)"
        var errorNotNill: Bool = false
        
        networking.executeRequest(url: url, UtilsHelper.buildAuthorizationHeader, authType: "basic", userAuth: UserAuth()){
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
