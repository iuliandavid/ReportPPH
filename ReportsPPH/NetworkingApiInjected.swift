//
//  NetworkingApiInjected.swift
//  ReportsPPH
//
//  Created by iulian david on 12/27/16.
//  Copyright © 2016 iulian david. All rights reserved.
//

import Foundation

protocol NetworkingApiInjected { }

extension NetworkingApiInjected {
    var networking:NetworkingApi { get { return InjectionMap.networking } }
}
