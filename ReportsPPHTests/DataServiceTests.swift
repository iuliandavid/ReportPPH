//
//  DataServiceTests.swift
//  ReportsPPH
//
//  Created by iulian david on 12/3/16.
//  Copyright © 2016 iulian david. All rights reserved.
//

import XCTest
@testable import ReportsPPH


class DataServiceTests: XCTestCase {
    
    let userAuth = DataService.instance.user!
    
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
    
    func testShouldSaveDataToUserDefaults() {
        //Given
        
        XCTAssertNotNil(DataService.instance.user)
        
        userAuth.username = "TestUser"
        userAuth.password = "TestPassword"
        
        
        let tokenInfo = userAuth.tokenInfo ?? TokenInfo()
        
        tokenInfo.access_token = "at"
        tokenInfo.refresh_token = "rt"
        
        userAuth.tokenInfo = tokenInfo
        //When
        
        DataService.instance.user = userAuth
        DataService.instance.saveUserData()
        
        
        //Then
        DataService.instance.user = nil
        XCTAssertNil(DataService.instance.user)
        
        DataService.instance.loadUserData()
        XCTAssertTrue(DataService.instance.user?.password == userAuth.password)
        
        XCTAssertTrue(DataService.instance.user?.tokenInfo?.refresh_token == "rt")
        
    }
    
}
