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
    
    
    private  init(){

        let configDict = UtilsHelper.loadFromConfigFile(fileName: "Config", params: ["wsUrl", "wsApi"])
        wsUrl = configDict?["wsUrl"]
        wsApi = configDict?["wsApi"]
        
    }
    
    
    }
