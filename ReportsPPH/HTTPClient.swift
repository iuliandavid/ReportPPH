//
//  HTTPClient.swift
//  ReportsPPH
//
//  Created by iulian david on 12/30/16.
//  Copyright © 2016 iulian david. All rights reserved.
//

import Foundation
typealias HTTPResult = (Int?, Any?, MyError?) -> ()

/**
 
 Default HTTP client with JSON parsing of the result
 
 It executes a request and tries to extract the JSON response
 
 Returns by default the HTTP status code, the Objects in JSON if deserialized, The error if something wrong happened
 
 ### Usage Example: ###
 ````
 let httpClient = HTTPClient()
 httpClient.executeRequest(url: request as URLRequest, completion: 
    {
        (statusCode, jsonData, error)
        in 
        /..../
    }
 ````
 
 */
class HTTPClient {
    
    /// The URL session instance
    private let session: URLSessionProtocol
    
    /**
     
     Default constructor
     
     Can be mocked see, tests
     
     - Parameter session: The URL session instance.
        
        Defaults to **URLSession.shared**
     
     */
    init(session: URLSessionProtocol = Config.instance.urlSession) {
        self.session = session
    }
    
    /**
     
     Executes a HTTP request and parses the reponse to JSON if possible
     
     - Parameter url: The request to be executed, can be any type of request
     - Parameter completion: The closure to be executed on finishing the request
    */
    func executeRequest(url: URLRequest, completion: @escaping HTTPResult) {
        
        let task = session.dataTask(request: url) { (data, response, error) -> Void in
            let resp = response as? HTTPURLResponse
            var json:Any?
            var err: MyError? = nil
            if let _ = error {
                err = MyError.NetworkError
            } else if let _ = resp, let statusCode = resp?.statusCode, (200...299 ~= statusCode || 400...499 ~= statusCode) {
                guard data != nil else{
                    completion(statusCode, nil, nil)
                    return
                }
                do{
                    json = try JSONSerialization.jsonObject(with: data!, options:.allowFragments)
                    
                }catch {
                    err = MyError.UnhandledError("Unable to deserialize the response: code:\(statusCode) to JSON")
                }
                
            } else {
                guard  let statusCode = resp?.statusCode else {
                    err = MyError.UnhandledError("Unauthorized call:\(1000)")
                    completion(1000, nil, err)
                    return
                }
                err = MyError.UnhandledError("Unauthorized call:\(statusCode)")
                
            }
            completion(resp?.statusCode, json, err)
        }
        task.resume()
    }
}
