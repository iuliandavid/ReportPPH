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
        
        completed()
    }
    
    //persists the authorization data to UserDefaults
    func saveUserData() {
        
        //Trebuie setat NsKeyedArchiver
        let userAuth = NSKeyedArchiver.archivedData(withRootObject: user ?? UserAuth())
        //asta se stocheaza serializat
        UserDefaults.standard.set(userAuth, forKey: "userAuth")
        UserDefaults.standard.synchronize()
    }
    
    //loads the authorization data from UserDefaults
    func loadUserData(){
        
        guard let loadedUserData = UserDefaults.standard.data(forKey: "userAuth") as Data? , let userData = NSKeyedUnarchiver.unarchiveObject(with: loadedUserData) as? UserAuth
            else {
                user = UserAuth()
                return
        }
        
        
        self.user = userData
        
    }
}
