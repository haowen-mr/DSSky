//
//  AmapLocationTool.swift
//  DSSky
//
//  Created by 左得胜 on 2019/2/22.
//  Copyright © 2019 左得胜. All rights reserved.
//

import Foundation
import AMapLocationKit

class AMapLocationTool: NSObject {
    // MARK: - Property
    private lazy var locationManager: AMapLocationManager = {
        let locationManager = AMapLocationManager()
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationManager.locationTimeout = 5
        locationManager.reGeocodeTimeout = 3
        locationManager.delegate = self
        
        return locationManager
    }()
    
    static let shared = AMapLocationTool()
    private override init() {
        
    }
    
    // MARK: - Public Method
    func registerAMap() {
        AMapServices.shared()?.apiKey = kAPPKEY.aMap
    }
    
    func requestLocation(isReGeocode: Bool, completion: @escaping AMapLocatingCompletionBlock) {
        locationManager.requestLocation(withReGeocode: isReGeocode, completionBlock: completion)
    }
}

extension AMapLocationTool: AMapLocationManagerDelegate {
    func amapLocationManager(_ manager: AMapLocationManager!, didFailWithError error: Error!) {
        QL1(error)
    }
    
    func amapLocationManager(_ manager: AMapLocationManager!, didChange status: CLAuthorizationStatus) {
        QL1(status)
        switch status {
        case .authorizedWhenInUse, .authorizedAlways:
            break
        case .notDetermined:
            break
        case .denied, .restricted:
            DSPrivacyIsAuthorized.openSettings()
        default:
            break
        }
    }
}

