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
