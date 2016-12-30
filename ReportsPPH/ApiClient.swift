//
//  ApiClient.swift
//  ReportsPPH
//
//  Created by iulian david on 12/2/16.
//  Copyright © 2016 iulian david. All rights reserved.
//

import Foundation


/// Singleton for Api accesses
class ApiClient: NetworkingApi {
    
    static let instance = ApiClient()
    
    var httpClient: HTTPClient!
    
    private init(){
        httpClient = HTTPClient()
    }
    func executeRequest(url: String,_ authorizationHeader: (String, UserAuth) -> String?, authType: String, userAuth: UserAuth,  completed: @escaping RequestCompleted){
        
        
        let request = NSMutableURLRequest(url: NSURL(string: url)! as URL,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10.0)
        request.httpMethod = "POST"
        
        
        
        if let authHeader = authorizationHeader(authType,userAuth)  {

            request.addValue(authHeader, forHTTPHeaderField: "authorization")
        }
        
        httpClient.executeRequest(url: request as URLRequest, completion: {(statusCode, jsonData, error) in
            completed(statusCode, jsonData, error)
        })
    }
    
    
    /**
     
     Builds a HTTP request based on an username and a password and executes the access token request through a HTTP POST
     
     Curl equivalent
     ```sh
     curl -X POST -H "Authorization: Basic [Base64(clientID:clientSecret)]" -H "Content-Type: application/x-www-form-urlencoded" -H "Cache-Control: no-cache" -d 'grant_type=password&username=[username]&password=[password]' "http://[API_URL]/[API_NAME]/[API_OAUTH_ENDPOINT]"
     ```
     
     Since the HTTP request is async the result will be retrieved reading the **AccessTokenReceived** closure
     
     - parameter username: The username set at the Login .
     - parameter password: The password set at the Login .
     - parameter completed: A closure containing the result of the authentication.
     
    */
    func executeAccessTokenRequest(username: String, password: String, completed: @escaping AccessTokenReceived ) {
        
        let url = "\(Config.instance.wsUrl!)/\(Config.instance.wsApi!)/\(Config.API_OAUTH_ENDPOINT)"
        
        let request = NSMutableURLRequest(url: NSURL(string: url)! as URL,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 30.0)
        
        if let authHeader = UtilsHelper.buildAuthorizationHeader("basic",UserAuth())  {
            
            request.addValue(authHeader, forHTTPHeaderField: "authorization")
        }
        
        request.httpMethod = "POST"
        
        let postData = NSMutableData(data: "grant_type=password".data(using: String.Encoding.utf8)!)
        postData.append("&username=\(username)".data(using: String.Encoding.utf8)!)
        postData.append("&password=\(password)".data(using: String.Encoding.utf8)!)
        
        request.httpBody = postData as Data
        
        httpClient.executeRequest(url: request as URLRequest, completion: {(statusCode, jsonData, error) in
            if let err = error {
                print(err)
                completed(Result.Failure(MyError.UnhandledError(err.localizedDescription)))
            } else {
                guard let httpResponse = jsonData as? [String: AnyObject] else {
                    
                    completed(Result.Failure(MyError.AuthenticationFailure("Error decoding the result: \(jsonData)")))
                    return
                }
                print(httpResponse)
                if statusCode! == 200 {
                    let tokenInfo = TokenInfo()
                    tokenInfo.access_token = httpResponse["access_token"] as? String
                    tokenInfo.refresh_token = httpResponse["refresh_token"] as? String
                    completed(Result.Success(tokenInfo))
                } else {
                    guard let error_description = httpResponse["error_description"] as? String
                        else {
                            completed(Result.Failure(MyError.UnhandledError(httpResponse.description)))
                            return
                        }
                    
                    completed(Result.Failure(MyError.AuthenticationFailure(error_description)))
                }
            }
        })
        
    }

//    /**
//    Executes a HTTP request, parses the response if any into JSON and passes the results: HTTP status code, JSON result and error to a closure
//    */
//    private func executeApiRequest(request: NSMutableURLRequest,completed: @escaping RequestCompleted){
//        
//        let session = URLSession.shared
//        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
//            
//            let resp = response as? HTTPURLResponse
//            var json:Any?
//            if (error == nil) {
//                
//                do{
//                    
//                    json = try JSONSerialization.jsonObject(with: data!, options:.allowFragments)
//                    
//                }catch {
//                    print("Error with Json: \(error)")
//                }
//                
//            }
//            completed(resp?.statusCode, json, error)
//            
//        })
//        
//        dataTask.resume()
//
//    }
}
