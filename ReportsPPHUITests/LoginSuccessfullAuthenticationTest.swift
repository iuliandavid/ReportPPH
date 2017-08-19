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
class LoginSuccessfullAuthenticationTest: XCTestCase {
    let app = XCUIApplication()
    
    
    
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        
        let TEST_URL = "http://127.0.0.1:8080/ReportsWS/oauth/token"

        app.launchArguments += ["UI-TESTING"]
        app.launchEnvironment[TEST_URL] = "{\"access_token\": \"access_token\", \"refresh_token\": \"refresh_token\"} "
       
        app.launch()
        
        
        
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func  testFullAuthenticatication()  {
       
        let usernameTextField = app.textFields["usernameText"]
        let passwordTextField = app.secureTextFields["passwordText"]
        usernameTextField.tap()
        usernameTextField.typeText("")
        usernameTextField.typeText("test")
        
        
        passwordTextField.tap()
        passwordTextField.tap()
        passwordTextField.typeText("test")
        app.buttons["Login"].tap()

        ///introduce a delay and then show AppVC with wellcomeLabel's text **Logged in** app.labels.
        let navigationBar = app.navigationBars["Welcome"]
        let exists = NSPredicate(format: "exists == true")
        expectation(for: exists, evaluatedWith: navigationBar, handler: nil)
        waitForExpectations(timeout: 5, handler: nil)

    }
    
     
    
}
