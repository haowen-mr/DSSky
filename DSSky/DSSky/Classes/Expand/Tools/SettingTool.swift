//
//  SettingTool.swift
//  DSSky
//
//  Created by 左得胜 on 2019/2/28.
//  Copyright © 2019 左得胜. All rights reserved.
//

import Foundation

enum DateType: Int {
    case text
    case digit
    
    var format: String {
        return self == .text ? "E, dd MMMM" : "EEEEE, MM/dd"
    }
}

enum TemperatureType: Int {
    /// 摄氏
    case celsius
    /// 华氏温度
    case fahrenheit
}

class SettingTool {
    class func dateType() -> DateType {
        return DateType(rawValue: Defaults[.dateType]) ?? .text
    }
    
    class func setDateType(to value: DateType) {
        Defaults[.dateType] = value.rawValue
    }
    
    class func temperatureType() -> TemperatureType {
        return TemperatureType(rawValue: Defaults[.temperatureType]) ?? .celsius
    }
    
    class func setTemperatureType(to value: TemperatureType) {
        Defaults[.temperatureType] = value.rawValue
    }
}
