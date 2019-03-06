//
//  CurrentLocationViewModel.swift
//  DSSky
//
//  Created by 左得胜 on 2019/3/2.
//  Copyright © 2019 左得胜. All rights reserved.
//

import Foundation

struct CurrentLocationViewModel {
    var location: LocationModel
    
    var city: String {
        return location.name
    }
    
    static let empty = CurrentLocationViewModel(location: LocationModel.empty)
    static let invalid = CurrentLocationViewModel(location: LocationModel.invalid)
    
    var isEmpty: Bool {
        return self.location == LocationModel.empty
    }
    
    var isInvalid: Bool {
        return self.location == LocationModel.invalid
    }
}
