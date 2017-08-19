//
//  LoginTests.swift
//  ReportsPPH
//
//  Created by iulian david on 11/26/16.
//  Copyright © 2016 iulian david. All rights reserved.
//

import XCTest
@testable import ReportsPPH


class LoginTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    /**
     Test if it loads the config files
    */
    func testConfigInit(){
        let instance = Config.instance
        
        XCTAssertNotNil(instance.wsApi)
        XCTAssertNotNil(instance.wsUrl)
        
        //force unwrapp the values since if they are null the tests before fail
        print(instance.wsApi!)
        print(instance.wsUrl!)
        
    }
    
}
