//
//  NetURLSessionProtocol.swift
//  DSSky
//
//  Created by 左得胜 on 2019/2/21.
//  Copyright © 2019 左得胜. All rights reserved.
//

import Foundation

typealias DataTaskClosure = (Data?, URLResponse?, Error?) -> Void
protocol NetURLSessionProtocol {
    func dataTask(with request: URLRequest, completionHandler: @escaping DataTaskClosure) -> NetURLSessionDataTaskProtocol
}
