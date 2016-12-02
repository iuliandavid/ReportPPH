//
//  DataService.swift
//  ReportsPPH
//
//  Created by iulian david on 11/29/16.
//  Copyright © 2016 iulian david. All rights reserved.
//

import Foundation

typealias TestLoginCompleted = () -> ()


class DataService {
    
    
    static let instance = DataService()
    
    /**
     Variable that stores the login status
    */
    var isUserLoggedIn = false
    
    
    /**
     Test if we saved the login credentials
     If we get the login credentials we issue a login
    */
    func testLogin(completed: @escaping TestLoginCompleted){
        
        
        
        completed()
    }
    
    
}
