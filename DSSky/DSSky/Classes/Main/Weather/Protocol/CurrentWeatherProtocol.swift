//
//  CurrentWeatherProtocol.swift
//  DSSky
//
//  Created by 左得胜 on 2019/2/22.
//  Copyright © 2019 左得胜. All rights reserved.
//

import UIKit

protocol CurrentWeatherProtocol {
    var city: String { get }
    var temperature: String { get }
    var weatherIcon: UIImage { get }
    var humidity: String { get }
    var summary: String { get }
    var date: String { get }
}


