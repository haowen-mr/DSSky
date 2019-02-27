//
//  NetworkTool.swift
//  DSSky
//
//  Created by 左得胜 on 2019/2/21.
//  Copyright © 2019 左得胜. All rights reserved.
//

import Foundation

enum NetError: Error {
    case failedRequest
    case invalidResponse
    case unknown
}

class NetURLSession: NetURLSessionProtocol {
    func dataTask(with request: URLRequest, completionHandler: @escaping DataTaskClosure) -> NetURLSessionDataTaskProtocol {
        return NetURLSessionDataTask(request: request, completion: completionHandler)
    }
    
}

class NetURLSessionDataTask: NetURLSessionDataTaskProtocol {
    private let request: URLRequest
    private let completion: NetURLSessionProtocol.DataTaskClosure
    
    init(request: URLRequest, completion: @escaping NetURLSessionProtocol.DataTaskClosure) {
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
    
    typealias CompletionHandler = (WeatherModel?, NetError?) -> Void
    
    private let baseURL: URL
    let urlSession: NetURLSessionProtocol
    
    init(baseURL: URL, urlSession: NetURLSessionProtocol) {
        self.baseURL = baseURL
        self.urlSession = urlSession
    }
    
    func request(lat: Double, lon: Double, completion: @escaping CompletionHandler) {
        let url = baseURL.appendingPathComponent("\(lat),\(lon)")
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "GET"
        
        urlSession.dataTask(with: request) { (data, response, error) in
            self.didFinishGettingWeatherData(data: data, response: response, error: error, completion: completion)
        }.resume()
    }
    
    private func didFinishGettingWeatherData(data: Data?, response: URLResponse?, error: Error?, completion: CompletionHandler) {
        if let _ = error {
            completion(nil, .failedRequest)
        } else if let data = data, let response = response as? HTTPURLResponse {
            if response.statusCode == 200 {
                do {
                    let decoder = JSONDecoder()
                    decoder.dateDecodingStrategy = .secondsSince1970
                    let weatherData = try decoder.decode(WeatherModel.self, from: data)
                    
                    completion(weatherData, nil)
                } catch {
                    completion(nil, .invalidResponse)
                }
            } else {
                completion(nil, .failedRequest)
            }
        } else {
            completion(nil, .unknown)
        }
    }
    
}
