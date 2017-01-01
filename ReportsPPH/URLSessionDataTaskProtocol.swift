//
//  URLSessionDataTaskProtocol.swift
//  ReportsPPH
//
//  Created by iulian david on 12/29/16.
//  Copyright © 2016 iulian david. All rights reserved.
//

import Foundation
protocol URLSessionDataTaskProtocol {
    func resume()
}

extension URLSessionDataTask: URLSessionDataTaskProtocol { }
