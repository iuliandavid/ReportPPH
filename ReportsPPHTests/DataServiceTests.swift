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
    
    let userAuth = DataServiceImpl.instance.user!
    
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
        var dataService:DataService = DataServiceImpl.instance
        
        XCTAssertNotNil(dataService.user)
        
        userAuth.username = "TestUser"
        userAuth.password = "TestPassword"
        
        
        let tokenInfo = userAuth.tokenInfo ?? TokenInfo()
        
        tokenInfo.access_token = "at"
        tokenInfo.refresh_token = "rt"
        
        userAuth.tokenInfo = tokenInfo
       
        //When
        dataService.user = userAuth
        dataService.saveUserData()
        
        
        //Then
        dataService.user = nil
        XCTAssertNil(dataService.user)
        
        dataService.loadUserData()
        XCTAssertTrue(dataService.user?.password == userAuth.password)
        
        XCTAssertTrue(dataService.user?.tokenInfo?.refresh_token == "rt")
        dataService.user = nil
        dataService.saveUserData()
    }
    
}
