//
//  CurrentWeatherUITests.swift
//  DSSkyUITests
//
//  Created by 左得胜 on 2019/2/28.
//  Copyright © 2019 左得胜. All rights reserved.
//

import XCTest

class CurrentWeatherUITests: XCTestCase {
    
    let app = XCUIApplication()

    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        
        app.launchArguments += ["UI-TESTING"]
        let json = """
        {
            "longitude" : 100,
            "latitude" : 52,
            "currently" : {
                "temperature" : 23,
                "humidity" : 0.91,
                "icon" : "snow",
                "time" : 1507180335,
                "summary" : "Light Snow"
            }
        }
"""
        app.launchEnvironment["FakeJSON"] = json
        app.launch()
    }

    override func tearDown() {
        super.tearDown()
    }

    func test_locationBtnExist() {
        let locationBtn = app.buttons["LocationBtn"]
//        let exists = NSPredicate(format: "exists == true")
//
//        expectation(for: exists, evaluatedWith: locationBtn, handler: nil)
//        waitForExpectations(timeout: 10, handler:nil)
        
        XCTAssert(locationBtn.exists)
    }
    
    func test_currentWeatherDisplay() {
        XCTAssert(app.images["snow"].exists)
        XCTAssert(app.staticTexts["Light Snow"].exists)
    }
}
