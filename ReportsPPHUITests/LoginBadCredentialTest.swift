//
//  LoginSuccessfullAuthenticationTest.swift
//  ReportsPPH
//
//  Created by iulian david on 12/31/16.
//  Copyright © 2016 iulian david. All rights reserved.
//

import XCTest
@testable import ReportsPPH

@available(iOS 9.0, *)
class LoginBadCredentialTest: XCTestCase {
    let app = XCUIApplication()
    
    
    
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        
        let TEST_URL = "http://127.0.0.1:8080/ReportsWS/oauth/token"

        app.launchArguments += ["UI-TESTING"]
        app.launchEnvironment[TEST_URL] = "{\"error\": \"invalid_grant\", \"error_description\": \"Bad credentials\"} "
        app.launch()
       
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    
    func testBadCredentials() {
        
        let usernameTextField = app.textFields["usernameText"]
        usernameTextField.tap()
        usernameTextField.typeText("")
        usernameTextField.typeText("bad_user")
        
        let passwordTextField = app.secureTextFields["passwordText"]
        passwordTextField.tap()
        passwordTextField.typeText("bad_password")
        app.buttons["Login"].tap()
        
        let label = app.alerts["Authentication Failure"].staticTexts["Bad credentials"]
        let exists = NSPredicate(format: "exists == true")
        expectation(for: exists, evaluatedWith: label, handler: nil)
        waitForExpectations(timeout: 5, handler: nil)
   
    }
     
    
}
