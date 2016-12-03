//
//  ApiClient.swift
//  ReportsPPH
//
//  Created by iulian david on 12/2/16.
//  Copyright © 2016 iulian david. All rights reserved.
//

import Foundation

typealias RequestCompleted = (Int?, Any?, Error?) -> ()

/// Singleton for Api accesses
class ApiClient {
    
    static let instance = ApiClient()
    
    func executeRequest(url: String,_ authorizationHeader: (String, UserAuth) -> String?, authType: String, userAuth: UserAuth,  completed: @escaping RequestCompleted){
        
        
        let request = NSMutableURLRequest(url: NSURL(string: url)! as URL,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10.0)
        request.httpMethod = "POST"
        
        
        
        if let authHeader = authorizationHeader(authType,userAuth)  {

            request.addValue(authHeader, forHTTPHeaderField: "authorization")
        }
        
        executeApiRequest(request: request, completed: {(statusCode, jsonData, error) in
            completed(statusCode, jsonData, error)
        })
    }
    
    
    
    
    private func executeApiRequest(request: NSMutableURLRequest,completed: @escaping RequestCompleted){
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            
            let resp = response as? HTTPURLResponse
            var json:Any?
            if (error == nil) {
                
                do{
                    
                    json = try JSONSerialization.jsonObject(with: data!, options:.allowFragments)
                    
                }catch {
                    print("Error with Json: \(error)")
                }
                
            }
            completed(resp?.statusCode, json, error)
            
        })
        
        dataTask.resume()

    }
}
