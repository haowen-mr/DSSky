//
//  SettingsDateViewModel.swift
//  DSSky
//
//  Created by 左得胜 on 2019/2/28.
//  Copyright © 2019 左得胜. All rights reserved.
//

import UIKit

struct SettingsDateViewModel: SettingsProtocol {
    let dateType: DateType
    
    var labelText: String {
        return dateType == .text ? "Fri, 01 December" : "F, 12/01"
    }
    
    var accessory: UITableViewCell.AccessoryType {
        if SettingTool.dateType() == dateType {
            return .checkmark
        } else {
            return .none
        }
    }
}

