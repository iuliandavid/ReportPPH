//
//  MockURLSession.swift
//  ReportsPPH
//
//  Created by iulian david on 12/29/16.
//  Copyright © 2016 iulian david. All rights reserved.
//

import Foundation
@testable import ReportsPPH

class MockURLSession: URLSessionProtocol {
    var nextDataTask = MockURLSessionDataTask()
    var nextData: Data?
    var nextError: Error?
    private (set) var lastURL: URL?
    
    func dataTask(request with: URLRequest, completionHandler: @escaping DataTaskResult) -> URLSessionDataTaskProtocol {
        lastURL = with.url
        completionHandler(nextData, nil, nextError)
        return nextDataTask
    }
    
    
    
//    override func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> MockURLSessionTask {
//        self.url = request.url
//        return dataTask
//    }
    
}
