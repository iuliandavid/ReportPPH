//
//  MyError.swift
//  ReportsPPH
//
//  Created by iulian david on 12/31/16.
//  Copyright © 2016 iulian david. All rights reserved.
//

import Foundation

/**
 Custom Error handling for failures on networking operations
 */
enum MyError: Error {
    case AuthenticationFailure(String)
    case UnhandledError(String)
    case NetworkError
    
    
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
        case .NetworkError:
            return "No internet connection"
        }
    }
    
}

extension MyError: Equatable {
}

/**
 Describing the equal sign for MyError enums
 */
func ==(lhs: MyError, rhs: MyError) -> Bool {
    switch (lhs, rhs) {
        
    case (let .AuthenticationFailure(message1), let .AuthenticationFailure(message2)):
        return message1 == message2
    case (let .UnhandledError(message1), let .UnhandledError(message2)):
        return message1 == message2
    case (.NetworkError, .NetworkError):
        return true
        
    default:
        return false
    }
}
