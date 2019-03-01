//
//  WeatherDataManagerTest.swift
//  DSSkyTests
//
//  Created by 左得胜 on 2019/2/27.
//  Copyright © 2019 左得胜. All rights reserved.
//

import XCTest
@testable import DSSky

class WeatherDataManagerTest: XCTestCase {
    let url = URL(string: "https://darksky.net")!
    var session: MockURLSession!
    var manager: NetworkTool!

    override func setUp() {
        super.setUp()
        
        self.session = MockURLSession()
        self.manager = NetworkTool(baseURL: url, urlSession: session)
    }

    override func tearDown() {
        super.tearDown()
    }
    
    func test_weatherDataAt_startsTheSession() {
        let dataTask = MockURLSessionDataTask()
        session.sessionDataTask = dataTask
        
        manager.request(lat: 52, lon: 100) { (_, _) in
            
        }
        XCTAssert(session.sessionDataTask.isResumeCalled)
    }
    
    func test_weatherDataAt_getsData() {
        let expect = expectation(description: "加载数据中……")
        var data: WeatherModel? = nil
        
        NetworkTool.shared.request(lat: 52, lon: 100) { (model, error) in
            data = model
            expect.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertNotNil(data)
    }
    
    func test_weatherDataAt_handle_invalidResponse() {
        session.responseError = NSError(domain: "Invalid Request", code: 100, userInfo: nil)
        
        var error: NetError? = nil
        manager.request(lat: 52, lon: 100) { (_, e) in
            error = e
        }
        
        XCTAssertEqual(error, NetError.failedRequest)
    }
    
    func test_weatherDataAt_handle_statusCode() {
        session.responseHeader = HTTPURLResponse(url: API.baseURL, statusCode: 400, httpVersion: nil, headerFields: nil)
        
        let data = "{}".data(using: .utf8)
        session.responseData = data
        
        var error: NetError? = nil
        manager.request(lat: 52, lon: 100) { (_, e) in
            error = e
        }
        
        XCTAssertEqual(error, NetError.failedRequest)
    }
    
    func test_weatherDataAt_invalidResponse() {
        session.responseHeader = HTTPURLResponse(url: API.baseURL, statusCode: 200, httpVersion: nil, headerFields: nil)
        
        let data = "{".data(using: .utf8)
        session.responseData = data
        
        var error: NetError? = nil
        manager.request(lat: 52, lon: 100) { (_, e) in
            error = e
        }
        
        XCTAssertEqual(error, NetError.invalidResponse)
    }
    
    func test_weatherDataAt_responseDecode() {
        session.responseHeader = HTTPURLResponse(url: API.baseURL, statusCode: 200, httpVersion: nil, headerFields: nil)
        
        let data = loadDataFromBundle(ofName: "DarkSky", ext: "json")
        session.responseData = data
        
        var model: WeatherModel? = nil
        manager.request(lat: 52, lon: 100) { (m, _) in
            model = m
        }
        
        let expectedWeekData = WeatherModel.WeekWeatherModel(data: [
            ForecastModel(
                time: Date(timeIntervalSince1970: 1507180335),
                temperatureLow: 66,
                temperatureHigh: 82,
                icon: "clear-day",
                humidity: 0.25)
            ])
        let expected = WeatherModel(
            latitude: 52,
            longitude: 100,
            currently: WeatherModel.CurrentWeatherModel(
                time: Date(timeIntervalSince1970: 1507180335),
                summary: "Light Snow",
                icon: UIImage(named: "snow")!,
                temperature: 23,
                humidity: "0.91"),
            daily: expectedWeekData)
        
        XCTAssertEqual(model?.latitude, expected.latitude)
    }

}
