//
//  InitialControllerTests.swift
//  ReportsPPH
//
//  Created by iulian david on 11/29/16.
//  Copyright © 2016 iulian david. All rights reserved.
//

import XCTest
@testable import ReportsPPH

class InitialControllerTests: XCTestCase {
    
    /** Instance of InitialViewController */
    var initialViewController : InitialViewController!
    
    override func setUp() {
        super.setUp()
        
        ///Because in iOS architecture the view controller is tightly coupled to it’s view,
        ///we need to initialise the our Initial.storyboard, then instantiate our ViewController from there
        let storyboard = UIStoryboard(name: "Initial", bundle: Bundle.main)
        initialViewController = storyboard.instantiateViewController(withIdentifier: "Initial") as! InitialViewController
        UIApplication.shared.keyWindow!.rootViewController = initialViewController
        
        // Test and Load the View at the Same Time!
        XCTAssertNotNil(initialViewController.view)

    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testT(){
        
    }
    
    
//    func testLoginConditionOnLoggedIn(){
//        
//        //Given
//        DataService.instance.isUserLoggedIn = true
//        
//        
//        print("DataService.instance.isUserLoggedIn \(DataService.instance.isUserLoggedIn)")
//        
//
//        
//        //Then
//        let appController = initialViewController.presentedViewController as! AppVC
//        
//        print("appContoller: \(appController.debugDescription)")
//        XCTAssertNotNil(appController.view)
//        
//    }
}
