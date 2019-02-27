//
//  MockURLSessionDataTask.swift
//  DSSkyTests
//
//  Created by 左得胜 on 2019/2/27.
//  Copyright © 2019 左得胜. All rights reserved.
//

import Foundation
@testable import DSSky

class MockURLSessionDataTask: NetURLSessionDataTaskProtocol {
    private (set) var isResumeCalled = false
    
    func resume() {
        isResumeCalled = true
    }
    
}
