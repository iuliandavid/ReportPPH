//
//  DataServiceImpl.swift
//  ReportsPPH
//
//  Created by iulian david on 11/29/16.
//  Copyright © 2016 iulian david. All rights reserved.
//

import Foundation


class DataServiceImpl: DataService {
    
    
    static let instance = DataServiceImpl()
    
    private var _user: UserAuth?
    
    
    var user: UserAuth? {
        get{
            return self._user
        }
        set {
            _user = newValue
        }
    }
    
    private let keychain: KeychainSwift
    
    private init() {
        keychain = KeychainSwift()
        loadUserData()
    }
    
    /**
     Test if we saved the login credentials
     If we get the login credentials we issue a login
    */
    func testLogin(completed: @escaping TestLoginCompleted){
        
        if user?.tokenInfo != nil {
            completed(true)
        } else if let username = user?.username, let password = user?.password {
            networking.executeAccessTokenRequest(username: username, password: password){
                (result) in
                switch (result) {
                case .Success(let accessToken):
                    self.user?.tokenInfo = accessToken as? TokenInfo
                    self.saveUserData()
                    break
                case .Failure(let error) :
                    print(error, terminator: "\n")
                    break
                }
                completed(true)
            }
        } else {
            completed(false)
        }
        
        
    }
    
    
    //stores the authorization data into Keychain
    func saveUserData(){
        
        if user == nil {
            user = UserAuth()
        }
        let userAuth = NSKeyedArchiver.archivedData(withRootObject: user ?? UserAuth())
        keychain.set(userAuth, forKey: "userAuth")
        
    }
    
    
    //loads the authorization data from Keychain
    func loadUserData(){
        
        guard let loadedUserData = keychain.getData("userAuth") as Data? , let userData = NSKeyedUnarchiver.unarchiveObject(with: loadedUserData) as? UserAuth
            else {
                user = UserAuth()
                return
        }
        
        
        self.user = userData
        
    }
}

extension DataServiceImpl: NetworkingApiInjected {
    
}
