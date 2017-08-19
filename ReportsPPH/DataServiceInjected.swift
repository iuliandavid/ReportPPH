//
//  DataServiceInjected.swift
//  ReportsPPH
//
//  Created by iulian david on 12/27/16.
//  Copyright © 2016 iulian david. All rights reserved.
//

import Foundation

protocol DataServiceInjected { }

extension DataServiceInjected {
    var dataService:DataService { get { return InjectionMap.dataService } }
}
