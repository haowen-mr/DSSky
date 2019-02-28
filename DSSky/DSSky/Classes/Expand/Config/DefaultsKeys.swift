//
//  DefaultsKeys.swift
//  DSSky
//
//  Created by 左得胜 on 2019/2/28.
//  Copyright © 2019 左得胜. All rights reserved.
//

import Foundation

// MARK: - UserDefaults
extension DefaultsKeys {
    static let notiTime = DefaultsKey<Date>("notiTime", defaultValue: Date())
    static let dateType = DefaultsKey<Int>("dateType", defaultValue: 0)
    static let temperatureType = DefaultsKey<Int>("temperatureType", defaultValue: 0)
}
