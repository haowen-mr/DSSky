//
//  MockURLSession.swift
//  DSSkyTests
//
//  Created by 左得胜 on 2019/2/27.
//  Copyright © 2019 左得胜. All rights reserved.
//

import XCTest
@testable import DSSky

class MockURLSession: NetURLSessionProtocol {
    var responseData: Data?
    var responseHeader: HTTPURLResponse?
    var responseError: Error?
    
    var sessionDataTask = MockURLSessionDataTask()
    
    func dataTask(with request: URLRequest, completionHandler: @escaping DataTaskClosure) -> NetURLSessionDataTaskProtocol {
        completionHandler(responseData, responseHeader, responseError)
        return sessionDataTask
    }
}

