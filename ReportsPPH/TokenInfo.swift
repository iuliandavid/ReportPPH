//
//  TokenInfo.swift
//  ReportsPPH
//
//  Created by iulian david on 12/2/16.
//  Copyright © 2016 iulian david. All rights reserved.
//

import Foundation

class TokenInfo : NSObject, NSCoding {
    

    private var _refresh_token: String?
    private var _access_token: String?

    
    var access_token: String? {
        get {
            return _access_token
        }
        set {
            if newValue != nil {
                _access_token = newValue
            }
        }
    }
    
    var refresh_token: String? {
        get {
            return _refresh_token
        }
        set {
            if newValue != nil {
                _refresh_token = newValue
            }
        }
    }
    
    override init(){
        
    }
    required convenience init?(coder aDecoder: NSCoder){
        self.init()
        self._refresh_token = (aDecoder.decodeObject(forKey: "refresh_token") as? String)
        self._access_token = (aDecoder.decodeObject(forKey: "access_token") as? String)
    }
    
    func  encode(with aCoder: NSCoder) {
        aCoder.encode(self._refresh_token, forKey: "refresh_token")
        aCoder.encode(self._access_token, forKey: "access_token")
    }
    
    
}
