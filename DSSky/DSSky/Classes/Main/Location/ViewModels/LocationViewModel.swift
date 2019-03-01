//
//  LocationViewModel.swift
//  DSSky
//
//  Created by 左得胜 on 2019/3/1.
//  Copyright © 2019 左得胜. All rights reserved.
//

import Foundation
import CoreLocation

struct LocationViewModel {
    let location: CLLocation?
    let locationText: String?
}

extension LocationViewModel: LocationProtocol {
    var labelText: String {
        if let locationText = locationText {
            return locationText
        } else if let location = location {
            return location.toString
        }
        return kTitle.loadError
    }
}
