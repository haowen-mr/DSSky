//
//  CurrentWeatherViewModel.swift
//  DSSky
//
//  Created by 左得胜 on 2019/2/22.
//  Copyright © 2019 左得胜. All rights reserved.
//

import UIKit

struct CurrentWeatherViewModel: CurrentWeatherProtocol {
    let formatter = DateFormatter()
    
    var location: LocationModel! {
        didSet {
            isLocationReady = location != nil
        }
    }
    
    var weather: WeatherModel! {
        didSet {
            isWeatherReady = weather != nil
        }
    }
    
    var isLocationReady = false
    var isWeatherReady = false
    
    var isUpdateReady: Bool {
        return isLocationReady && isWeatherReady
    }
        
    var locationModel: LocationModel {
        return location
    }
    
    var weatherModel: WeatherModel {
        return weather
    }
    
    // MARK: - 由于设置改动后会更改温度和适度的格式，但是不会重新加载数据，因此，这里的不能将温度湿度写入 fatmodel 里面
    var temperature: String {
        switch SettingTool.temperatureType() {
        case .fahrenheit:
            return String(format: "%.1f F", weather.currently.temperature)
        case .celsius:
            return String(format: "%.1f °C", weather.currently.temperature.toCelsius())
        }
    }
    
    var time: String {
        formatter.dateFormat = SettingTool.dateType().format
        return formatter.string(from: weather.currently.time)
    }
    
}
