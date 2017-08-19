//
//  NetworkingApi.swift
//  ReportsPPH
//
//  Created by iulian david on 12/27/16.
//  Copyright © 2016 iulian david. All rights reserved.
//

import Foundation

typealias RequestCompleted = (Int?, Any?, Error?) -> ()

typealias AccessTokenReceived = (Result<Any, MyError>) -> ()


protocol NetworkingApi: class {
    
    func executeAccessTokenRequest(username: String, password: String, completed: @escaping AccessTokenReceived )
    
    func executeRequest(url: String,_ authorizationHeader: (String, UserAuth) -> String?, authType: String, userAuth: UserAuth,  completed: @escaping RequestCompleted)
    
    var httpClient: HTTPClient {
        get
        set
    }
}
