//
//  InjectionMap.swift
//  ReportsPPH
//
//  Created by iulian david on 12/27/16.
//  Copyright © 2016 iulian david. All rights reserved.
//

import Foundation

/** 
 Defining the classes used for DataService and the ApiClient
 - Remark: 
    The UI testing for DataService is here implemented
    For Networking API the testing is done through HTTPClient mocking
 */
struct InjectionMap {
    static var dataService:DataService = ProcessInfo.processInfo.arguments.contains("UI-TESTING") ?  MockDataService() : DataServiceImpl.instance
    
    static var networking:NetworkingApi = ApiClient.instance
}
