//
//  SettingsTemperatureViewModel.swift
//  DSSky
//
//  Created by 左得胜 on 2019/2/28.
//  Copyright © 2019 左得胜. All rights reserved.
//

import Foundation

struct SettingsTemperatureViewModel: SettingsProtocol {
    let temperatureType: TemperatureType
    
    var labelText: String {
        return temperatureType == .celsius ? "Celsius" : "Fahrenhait"
    }
    
    var accessory: UITableViewCell.AccessoryType {
        if SettingTool.temperatureType() == temperatureType {
            return .checkmark
        } else {
            return .none
        }
    }
}
