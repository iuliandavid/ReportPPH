//
//  TokenInfo.swift
//  ReportsPPH
//
//  Created by iulian david on 12/2/16.
//  Copyright © 2016 iulian david. All rights reserved.
//

import Foundation

class TokenInfo : NSObject, NSCoding {
    

    var _refresh_token: String?
    var _access_token: String?

    
    
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
