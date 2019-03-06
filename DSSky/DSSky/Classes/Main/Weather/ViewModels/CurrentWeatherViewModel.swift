//
//  CurrentWeatherViewModel.swift
//  DSSky
//
//  Created by 左得胜 on 2019/2/22.
//  Copyright © 2019 左得胜. All rights reserved.
//

import UIKit

struct CurrentWeatherViewModel {
    
    let formatter = DateFormatter()
    var weatherModel: WeatherModel
    
    static let empty = CurrentWeatherViewModel(weatherModel: WeatherModel.empty)
    var isEmpty: Bool {
        return weatherModel == WeatherModel.empty
    }
    
    var isInvalid: Bool {
        return weatherModel == WeatherModel.invalid
    }
    
    // MARK: - 由于设置改动后会更改温度和适度的格式，但是不会重新加载数据，因此，这里的不能将温度湿度写入 fatmodel 里面
    var temperature: String {
        switch SettingTool.temperatureType() {
        case .fahrenheit:
            return String(format: "%.1f F", weatherModel.currently.temperature)
        case .celsius:
            return String(format: "%.1f °C", weatherModel.currently.temperature.toCelsius())
        }
    }
    
    var time: String {
        formatter.dateFormat = SettingTool.dateType().format
        return formatter.string(from: weatherModel.currently.time)
    }
    
}
