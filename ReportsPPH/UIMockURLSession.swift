//
//  UIMockURLSession.swift
//  ReportsPPH
//
//  Created by iulian david on 12/31/16.
//  Copyright © 2016 iulian david. All rights reserved.
//

import Foundation

typealias DataCompletion = (Data?, URLResponse?, Error?) -> Void

/// Stub URLSession for networkless tests
class UIMockURLSession: URLSession {
    
    override func dataTask(with: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        return UIMockDataTask(url: with, completion: completionHandler)
    }
}
