//
//  InjectionMap.swift
//  ReportsPPH
//
//  Created by iulian david on 12/27/16.
//  Copyright © 2016 iulian david. All rights reserved.
//

import Foundation

struct InjectionMap {
    static var dataService:DataService = ProcessInfo.processInfo.arguments.contains("UI-TESTING") ?  MockDataService() : DataServiceImpl.instance
    
    static var networking:NetworkingApi = ApiClient.instance
}
