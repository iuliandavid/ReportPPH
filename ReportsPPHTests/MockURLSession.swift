//
//  MockURLSession.swift
//  ReportsPPH
//
//  Created by iulian david on 12/29/16.
//  Copyright © 2016 iulian david. All rights reserved.
//

import Foundation

class MockURLSession: URLSessionProtocol {
    var nextDataTask = MockURLSessionDataTask()
    var nextData: Data?
    var nextError: Error?
    var nextResponse: HTTPURLResponse?
    private (set) var lastURL: URL?
    
    func dataTask(request with: URLRequest, completionHandler: @escaping DataTaskResult) -> URLSessionDataTaskProtocol {
        lastURL = with.url
        completionHandler(nextData, nextResponse, nextError)
        return nextDataTask
    }
    
    
}
