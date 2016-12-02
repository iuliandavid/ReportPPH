//
//  UserAuth.swift
//  ReportsPPH
//
//  Created by iulian david on 12/2/16.
//  Copyright © 2016 iulian david. All rights reserved.
//

import Foundation
class UserAuth: NSObject, NSCoding {
    
    var _tokeninfo: TokenInfo?
    var _username: String?
    var _password: String?
    
    override init(){
        
    }
    
    required convenience init?(coder aDecoder: NSCoder){
        self.init()
        self._tokeninfo = (aDecoder.decodeObject(forKey: "tokeninfo") as? TokenInfo)
        self._username = (aDecoder.decodeObject(forKey: "username") as? String)
        self._password = (aDecoder.decodeObject(forKey: "password") as? String)
    }
    
    func  encode(with aCoder: NSCoder) {
        aCoder.encode(self._password, forKey: "password")
        aCoder.encode(self._username, forKey: "username")
        aCoder.encode(self._tokeninfo, forKey: "tokeninfo")
    }
    
}
