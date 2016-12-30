//
//  MockURLSessionDataTask.swift
//  ReportsPPH
//
//  Created by iulian david on 12/29/16.
//  Copyright © 2016 iulian david. All rights reserved.
//

import Foundation
@testable import ReportsPPH


class MockURLSessionDataTask:URLSessionDataTaskProtocol {
    
    private (set) var resumeWasCalled = false
    
    func resume() {
        resumeWasCalled = true
    }
}
