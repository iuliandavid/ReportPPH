//
//  UserAuth.swift
//  ReportsPPH
//
//  Created by iulian david on 12/2/16.
//  Copyright © 2016 iulian david. All rights reserved.
//

import Foundation
class UserAuth: NSObject, NSCoding {
    
    private var _tokenInfo: TokenInfo?
    private var _username: String?
    private var _password: String?
    
    var tokenInfo: TokenInfo? {
        get {
            return _tokenInfo
        }
        set {
            if newValue != nil {
             _tokenInfo = newValue
            }
        }
    }
    
    
    var username: String? {
        get {
            return _username
        }
        set {
            if newValue != nil {
                _username = newValue
            }
        }
    }
    
    
    var password: String? {
        get {
            return _password
        }
        set {
            if newValue != nil {
            _password = newValue
            }
        }
    }
    
    
    override init(){
        
    }
    
    required convenience init?(coder aDecoder: NSCoder){
        self.init()
        self._tokenInfo = (aDecoder.decodeObject(forKey: "tokenInfo") as? TokenInfo)
        self._username = (aDecoder.decodeObject(forKey: "username") as? String)
        self._password = (aDecoder.decodeObject(forKey: "password") as? String)
    }
    
    func  encode(with aCoder: NSCoder) {
        aCoder.encode(self._password, forKey: "password")
        aCoder.encode(self._username, forKey: "username")
        aCoder.encode(self._tokenInfo, forKey: "tokenInfo")
    }
    
    
    
}
