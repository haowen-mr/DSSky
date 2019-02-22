//
//  CurrentWeatherViewModel.swift
//  DSSky
//
//  Created by 左得胜 on 2019/2/22.
//  Copyright © 2019 左得胜. All rights reserved.
//

import UIKit

struct CurrentWeatherViewModel: CurrentWeatherProtocol {
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
    
    var city: String {
        return location.name
    }
    
    var temperature: String {
        let value = weather.currently.temperature
        
        return String(format: "%.1f °C", value.toCelsius())
    }
    
    var weatherIcon: UIImage {
        return UIImage(named: weather.currently.icon) ?? UIImage(named: "clear-day")!
    }
    
    var humidity: String {
        return String(
            format: "%.1f %%",
            weather.currently.humidity * 100)
    }
    
    var summary: String {
        return weather.currently.summary
    }
    
    var date: String {
        let formatter = DateFormatter()
        return formatter.string(from: weather.currently.time)
    }
    
}
