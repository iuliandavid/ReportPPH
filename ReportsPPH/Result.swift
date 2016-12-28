//
//  Result.swift
//  ReportsPPH
//
//  Created by iulian david on 12/28/16.
//  Copyright © 2016 iulian david. All rights reserved.
//

import Foundation

/**
 Generic enum for networking operations results
 */
enum Result<T, U>{
    case Success(T)
    case Failure(U)
    
    
}


/**
 Custom Error handling for failures on networking operations
 */
enum MyError<String>: Error {
    case AuthenticationFailure(String)
    case UnhandledError(String)
    
    /**
     
     Retrieves the custom message appended to the error
    
     - returns: The message
     */
    var value: String {
        switch self {
        case .AuthenticationFailure(let message):
            return message
            
        case .UnhandledError(let message):
            return message
        }
    }
    
}
