//
//  HTTPClient.swift
//  ReportsPPH
//
//  Created by iulian david on 12/30/16.
//  Copyright © 2016 iulian david. All rights reserved.
//

import Foundation
typealias HTTPResult = (Data?, Error?) -> Void

class HTTPClient {
    private let session: URLSessionProtocol
    
    init(session: URLSessionProtocol = URLSession.shared) {
        self.session = session
    }
    
    func get(url: URLRequest, completion: HTTPResult) {
        let task = session.dataTask(request: url) { (_, _, _) -> Void in }
        task.resume()
    }
}
