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
    
    
    var user:UserAuth?
    
    private init() {
        loadUserData()
    }
    
    /**
     Test if we saved the login credentials
     If we get the login credentials we issue a login
    */
    func testLogin(completed: @escaping TestLoginCompleted){
        
        if user?.tokenInfo != nil {
            isUserLoggedIn = true
        } else if let username = user?.username, let password = user?.password {
            
        }
        
        completed()
    }
    
    
    //stores the authorization data into Keychain
    func saveUserData(){
         let keychain = KeychainSwift()
        
        if user == nil {
            user = UserAuth()
        }
        let userAuth = NSKeyedArchiver.archivedData(withRootObject: user ?? UserAuth())
        keychain.set(userAuth, forKey: "userAuth")
        
    }
    
    
    //loads the authorization data from Keychain
    func loadUserData(){
        
        let keychain = KeychainSwift()
        
        guard let loadedUserData = keychain.getData("userAuth") as Data? , let userData = NSKeyedUnarchiver.unarchiveObject(with: loadedUserData) as? UserAuth
            else {
                user = UserAuth()
                return
        }
        
        
        self.user = userData
        
    }
}
