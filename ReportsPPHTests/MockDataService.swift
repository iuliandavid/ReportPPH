//
//  MockDataService.swift
//  ReportsPPH
//
//  Created by iulian david on 12/28/16.
//  Copyright © 2016 iulian david. All rights reserved.
//

import Foundation
@testable import ReportsPPH

/**
 Class used for Data Service Tests that uses for keychain an in memory variable
 */
class MockDataService: DataService {
    
    private var mockUser: UserAuth?
    
    /** The In-Memory variable used to mock the Keychain */
    private var mockableKeychainedUser: UserAuth?
    
    init() {
        mockUser = UserAuth()
    }
    
    var user: UserAuth? {
        get{
            return self.mockUser
        }
        set {
            mockUser = newValue
        }
    }
    
    
    func testLogin(completed: @escaping TestLoginCompleted){
        
    }
    
    /**
    Mock a persistence save with the use of **mockableKeychainedUser**
    */
    func saveUserData(){
        mockableKeychainedUser = mockUser
    }
    
    
    /**
     Mock a persistence load with the use of **mockableKeychainedUser**
     */
    func loadUserData(){
        mockUser = mockableKeychainedUser
    }
    
}
