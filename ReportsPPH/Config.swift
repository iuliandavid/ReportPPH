//
//  Config.swift
//  ReportsPPH
//
//  Created by iulian david on 11/26/16.
//  Copyright © 2016 iulian david. All rights reserved.
//

import Foundation

/**
 Singleton that loads the config file
 and stores its values
 */
class Config {
    
    static let instance = Config()
    
    let wsUrl: String?
    
    let wsApi: String?
    
    let clientID: String?
    
    let clientSecret: String?
    
    private  init(){
        
        let configDict = UtilsHelper.loadFromConfigFile(fileName: "Config_debug", params: ["wsUrl", "wsApi", "clientID", "clientSecret"])
        wsUrl = configDict?["wsUrl"]
        wsApi = configDict?["wsApi"]
        clientID = configDict?["clientID"]
        clientSecret = configDict?["clientSecret"]
    }
    
    static let API_OAUTH_ENDPOINT = "/oauth/token"
    
    enum AnimationTimes: Double {
        case SHORT = 0.2
        case LONG = 1
    }
    
}
