//
//  UIMockDataTask.swift
//  ReportsPPH
//
//  Created by iulian david on 12/31/16.
//  Copyright © 2016 iulian david. All rights reserved.
//

import Foundation

/**
 
 Class needed to sutb the URLSession
 It will be used in tests, and it will search for the value set in **LoginSuccessfullAuthenticationTest** class for  **app.launchEnvironment**
 
 - SeeAlso:
    [Masillotti](http://masilotti.com/ui-testing-stub-network-data/)
 
 */
class UIMockDataTask: URLSessionDataTask {
    private let url: URLRequest
    private let completion: DataCompletion
    
    init(url: URLRequest, completion: @escaping DataCompletion) {
        self.url = url
        self.completion = completion
    }
    
    override func resume() {
        guard let url = url.url else {
            print("Error")
            return
        }

        if let json = ProcessInfo.processInfo.environment[url.absoluteString] {
            let data = json.data(using: String.Encoding.utf8)
            
            var response: HTTPURLResponse?
            if let json = try? JSONSerialization.jsonObject(with: data!) as? [String:Any],let _ = json?["error"] as? String {
                response = HTTPURLResponse(url: url, statusCode: 400,
                                           httpVersion: nil, headerFields: nil)
            } else {
                response = HTTPURLResponse(url: url, statusCode: 200,
                                           httpVersion: nil, headerFields: nil)
            }
        
            completion(data, response, nil)
        }
    }
}
