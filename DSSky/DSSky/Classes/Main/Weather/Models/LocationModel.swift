//
//  LocationModel.swift
//  DSSky
//
//  Created by 左得胜 on 2019/2/22.
//  Copyright © 2019 左得胜. All rights reserved.
//

import Foundation
import CoreLocation

struct LocationModel {
    private struct Keys {
        static let name = "name"
        static let latitude = "latitude"
        static let longitude = "longitude"
    }
    
    let name: String
    let latitude: Double
    let longitude: Double
    
    static let empty = LocationModel(name: "", latitude: 0, longitude: 0)
    static let invalid = LocationModel(name: "n/a", latitude: 0, longitude: 0)
    
    var location: CLLocation {
        return CLLocation(latitude: latitude, longitude: longitude)
    }
    
    var toDict: [String: Any] {
        return [
            "name": name,
            "latitude": latitude,
            "longitude": longitude
        ]
    }
    
    init(name: String, latitude: Double, longitude: Double) {
        self.name = name
        self.latitude = latitude
        self.longitude = longitude
    }
    
    init?(from dict: [String: Any]) {
        guard let name = dict[Keys.name]
            as? String else { return nil }
        guard let latitude = dict[Keys.latitude]
            as? Double else { return nil }
        guard let longitude = dict[Keys.longitude]
            as? Double else { return nil }
        
        self.init(name: name, latitude: latitude, longitude: longitude)
    }
}

extension LocationModel: Equatable {
    
}
