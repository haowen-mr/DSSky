//
//  WeekWeatherDayViewModel.swift
//  DSSky
//
//  Created by 左得胜 on 2019/3/1.
//  Copyright © 2019 左得胜. All rights reserved.
//

import Foundation

struct WeekWeatherDayViewModel: WeekWeatherDayProtocol {
    let weatherModel: ForecastModel
    
    private let dateFormatter = DateFormatter()
    
    var week: String {
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: weatherModel.time)
    }
    
    var date: String {
        dateFormatter.dateFormat = "MMMM d"
        return dateFormatter.string(from: weatherModel.time)
    }
    
    var temperature: String {
        let min = format(temperature: weatherModel.temperatureLow)
        let max = format(temperature: weatherModel.temperatureHigh)
        
        return "\(min) - \(max)"
    }
    
    var weatherIcon: UIImage? {
        return UIImage(named: weatherModel.icon)
    }
    
    var humidity: String {
        return String(format: "%.0f %%", weatherModel.humidity * 100)
    }
    
    /// Helpers
    private func format(temperature: Double) -> String {
        switch SettingTool.temperatureType() {
        case .celsius:
            return String(format: "%.0f °C", temperature.toCelsius())
        case .fahrenheit:
            return String(format: "%.0f °F", temperature)
        }
    }
}
