//
//  CurrentWeatherViewModelTests.swift
//  DSSkyTests
//
//  Created by 左得胜 on 2019/3/1.
//  Copyright © 2019 左得胜. All rights reserved.
//

import XCTest
@testable import DSSky

class CurrentWeatherViewModelTests: XCTestCase {
    var vm: CurrentWeatherViewModel!
    
    override func setUp() {
        super.setUp()
        
        // 1. Load data
        let data = loadDataFromBundle(
            ofName: "DarkSky", ext: "json")
        
        // 2. Decode data
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .secondsSince1970
        let weatherModel = try! decoder.decode(
            WeatherModel.self, from: data)
        
        // 3. Create the view model
        vm = CurrentWeatherViewModel()
        let location = LocationModel(name: "Test City", latitude: 100, longitude: 100)
        
        vm.weather = weatherModel
        vm.location = location
    }
    
    func test_weather_summary() {
        XCTAssertEqual(vm.weatherModel.currently.summary, "Light Snow")
    }
    
    func test_humidity_display() {
        XCTAssertEqual(vm.weatherModel.currently.humidity, "91.0 %")
    }
}
