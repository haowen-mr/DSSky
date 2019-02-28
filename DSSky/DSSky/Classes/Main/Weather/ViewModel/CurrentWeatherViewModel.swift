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
        
    var locationModel: LocationModel {
        return location
    }
    
    var weatherModel: WeatherModel {
        return weather
    }
    
}
