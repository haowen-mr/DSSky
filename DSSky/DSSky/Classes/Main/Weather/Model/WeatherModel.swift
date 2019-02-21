//
//  WeatherModel.swift
//  DSSky
//
//  Created by 左得胜 on 2019/2/21.
//  Copyright © 2019 左得胜. All rights reserved.
//

import Foundation

struct WeatherModel: Codable {
    let latitude: Double
    let longitude: Double
    let currently: CurrentWeatherModel
    let daily: WeekWeatherModel
    
    struct CurrentWeatherModel: Codable {
        let time: Date
        let summary: String
        let icon: String
        let temperature: Double
        let humidity: Double
    }
    
    struct WeekWeatherModel: Codable {
        let data: [ForecastModel]
    }
}
