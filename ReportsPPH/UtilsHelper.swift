//
//  UtilsHelper.swift
//  ReportsPPH
//
//  Created by iulian david on 11/26/16.
//  Copyright © 2016 iulian david. All rights reserved.
//

import Foundation

/**
 Helper class with static methods
 to be used all arround the project
 
 - Author
    Iulian David
 */
class UtilsHelper {
    
    /**
     Reads from plist file and returns a dictionary with values for keys passed as parameter
     
      ```
        [key1, key2] -> [key1:value1, key2:value2]
     ```
     
     - parameters:
        - fileName:  The plist file
        - params: array containg the keys to search in the config file
     
     - Returns 
        A nillable dictionary with the found values for the keys passed as params
    */
    static func loadFromConfigFile(fileName: String, params: [String]) -> [String: String]? {
        var result: [String:String]?
        if let path = Bundle.main.path(forResource: fileName, ofType: "plist") {
            let url = URL(fileURLWithPath: path)
            let data = try! Data(contentsOf: url)
            let plist = try! PropertyListSerialization.propertyList(from: data, options: .mutableContainers, format: nil)
            
            if let configDict = plist as? [String: String] {
                for key in params {
                    if let value = configDict[key] {
                        if result == nil {
                            result = [String:String]()
                            
                        }
                        result?[key] = value
                    }
                    
                    
                }
                
            }
        }
        return result
    }

    static func buildAuthorizationHeader(_ authType: String,_ userAuth: UserAuth) -> String? {
        
        switch authType {
        case "basic":
            let basicAuth = "\(Config.instance.clientID!):\(Config.instance.clientSecret!)"
            let basicAuthUtf8 = basicAuth.data(using: String.Encoding.utf8)!
            let basicAuthBase64 = basicAuthUtf8.base64EncodedString()
            return "Basic \(basicAuthBase64)"
        case "bearer":
            return "Bearer \(userAuth._tokeninfo?._access_token)"
        default:
            return nil
        }
    }
}
