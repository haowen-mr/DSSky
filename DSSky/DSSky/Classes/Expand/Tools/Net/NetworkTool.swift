//
//  NetworkTool.swift
//  DSSky
//
//  Created by 左得胜 on 2019/2/21.
//  Copyright © 2019 左得胜. All rights reserved.
//

import Foundation
import SwiftyJSON
import RxSwift
import RxCocoa

enum NetError: Error {
    case failedRequest
    case invalidResponse
    case unknown
}

// MARK: - UI单元测试
class NetURLSession: NetURLSessionProtocol {
    func dataTask(with request: URLRequest, completionHandler: @escaping DataTaskClosure) -> NetURLSessionDataTaskProtocol {
        return NetURLSessionDataTask(request: request, completion: completionHandler)
    }
    
}
// MARK: - UI单元测试
class NetURLSessionDataTask: NetURLSessionDataTaskProtocol {
    private let request: URLRequest
    private let completion: DataTaskClosure
    
    init(request: URLRequest, completion: @escaping DataTaskClosure) {
        self.request = request
        self.completion = completion
    }
    
    func resume() {
        let json = ProcessInfo.processInfo.environment["FakeJSON"]
        
        if let json = json {
            let response = HTTPURLResponse(url: request.url!, statusCode: 200, httpVersion: nil, headerFields: nil)
            let data = json.data(using: .utf8)!
            
            completion(data, response, nil)
        }
    }
    
    
}

struct NetConfig {
    private static func isUITesting() -> Bool {
        return ProcessInfo.processInfo.arguments.contains("UI-TESTING")
    }
    
    static var urlSession: NetURLSessionProtocol {
        if isUITesting() {
            return NetURLSession()
        } else {
            return URLSession.shared
        }
    }
}

final class NetworkTool {
    static let shared = NetworkTool(baseURL: API.authenticatedURL, urlSession: NetConfig.urlSession)
        
    private let baseURL: URL
    let urlSession: NetURLSessionProtocol
    
    init(baseURL: URL, urlSession: NetURLSessionProtocol) {
        self.baseURL = baseURL
        self.urlSession = urlSession
    }
    
    func request(lat: Double, lon: Double) -> Observable<WeatherModel> {
        let url = baseURL.appendingPathComponent("\(lat),\(lon)")
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "GET"
        
        let MAX_ATTEMPTS = 3
        
        return (urlSession as! URLSession).rx.data(request: request).map {
//            QL1(try JSON(data: $0))
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .secondsSince1970
            let weatherData = try decoder.decode(WeatherModel.self, from: $0)
            return weatherData
        }
            .retryWhen({ (e) in
                e.enumerated()
                    .flatMap { (attempt, error) -> Observable<Int> in
                        if (attempt >= MAX_ATTEMPTS) {
                            return Observable.error(error)
                        } else {
                            return Observable<Int>.timer(Double(attempt + 1), scheduler: MainScheduler.instance).take(1)
                        }
                }
            })
            .materialize()
            .do(onNext: { QL1("DO: \($0)") })
            .dematerialize()
            .catchErrorJustReturn(WeatherModel.invalid)
    }
    
}
