//
//  WeatherModel.swift
//  DSSky
//
//  Created by 左得胜 on 2019/2/21.
//  Copyright © 2019 左得胜. All rights reserved.
//

import UIKit

struct WeatherModel: Decodable {
    let latitude: Double
    let longitude: Double
    let currently: CurrentWeatherModel
    let daily: WeekWeatherModel
    
    struct CurrentWeatherModel: Decodable {
        let time: Date
        let summary: String
        let icon: UIImage
        let temperature: Double
        let humidity: String
    }
    
    struct WeekWeatherModel: Decodable {
        let data: [ForecastModel]
    }
    
    static let empty = WeatherModel(latitude: 0, longitude: 0, currently: WeatherModel.CurrentWeatherModel(time: Date.from(string: "1970-01-01"), summary: "", icon: UIImage(named: "clear-day")!, temperature: 0, humidity: ""), daily: WeatherModel.WeekWeatherModel(data: []))
    
    static let invalid = WeatherModel(latitude: 0, longitude: 0, currently: WeatherModel.CurrentWeatherModel(time: Date.from(string: "1970-01-01"), summary: "n/a", icon: UIImage(named: "clear-day")!, temperature: 0, humidity: "0"), daily: WeatherModel.WeekWeatherModel(data: []))
}

extension WeatherModel.CurrentWeatherModel {
    enum CodingKeys: String, CodingKey {
        case time, summary, icon, temperature, humidity
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        time = values.ds_decode(Date.self, forKey: .time) ?? Date()
        summary = values.ds_decode(String.self, forKey: .summary)
        icon = UIImage(named: values.ds_decode(String.self, forKey: .icon)) ?? UIImage(named: "clear-day")!
        temperature = values.ds_decode(Double.self, forKey: .temperature)
        let humid = values.ds_decode(Double.self, forKey: .humidity)
        humidity = String(format: "%.1f %%", humid * 100)
    }
}

extension WeatherModel: Equatable {
    static func == (lhs: WeatherModel, rhs: WeatherModel) -> Bool {
        return lhs.latitude == rhs.latitude &&
            lhs.longitude == rhs.longitude &&
            lhs.currently == rhs.currently
    }
}

extension WeatherModel.CurrentWeatherModel: Equatable {
    static func == (lhs: WeatherModel.CurrentWeatherModel, rhs: WeatherModel.CurrentWeatherModel) -> Bool {
        return lhs.time == rhs.time &&
        lhs.summary == rhs.summary &&
        lhs.temperature == rhs.temperature &&
        lhs.humidity == rhs.humidity
    }
}

extension WeatherModel.WeekWeatherModel: Equatable {
    static func == (lhs: WeatherModel.WeekWeatherModel, rhs: WeatherModel.WeekWeatherModel) -> Bool {
        return lhs.data == rhs.data
    }
}
