//
//  CurrentWeatherProtocol.swift
//  DSSky
//
//  Created by 左得胜 on 2019/2/22.
//  Copyright © 2019 左得胜. All rights reserved.
//

import UIKit

protocol CurrentWeatherProtocol {
    var locationModel: LocationModel { get }
    var weatherModel: WeatherModel { get }
    var temperature: String { get }
    var time: String { get }
}


