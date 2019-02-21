//
//  CLLocation+Extension.swift
//  DSSky
//
//  Created by 左得胜 on 2019/2/21.
//  Copyright © 2019 左得胜. All rights reserved.
//

import Foundation
import CoreLocation

extension CLLocation {
    /// 经纬度描述
    var toString: String {
        let lat = String(format: "%.3f", coordinate.latitude)
        let lon = String(format: "%.3f", coordinate.longitude)
        
        return "\(lat), \(lon)"
    }
}
