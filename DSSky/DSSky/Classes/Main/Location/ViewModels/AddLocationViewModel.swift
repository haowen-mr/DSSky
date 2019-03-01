//
//  AddLocationViewModel.swift
//  DSSky
//
//  Created by 左得胜 on 2019/3/1.
//  Copyright © 2019 左得胜. All rights reserved.
//

import Foundation
import CoreLocation

class AddLocationViewModel {
    // MARK: - Property
    var queryText: String = "" {
        didSet {
            geocode(address: queryText)
        }
    }
    var numberOfLocations: Int { return locations.count }
    var hasLocationsResult: Bool {
        return numberOfLocations > 0
    }
    
    var queryingStatusDidChange: ((Bool) -> Void)?
    var locationsDidChange: (([LocationModel]) -> Void)?
    
    private var isQuerying = false {
        didSet {
            queryingStatusDidChange?(isQuerying)
        }
    }
    
    private var locations: [LocationModel] = [] {
        didSet {
            locationsDidChange?(locations)
        }
    }
    private lazy var geocoder = CLGeocoder()
    
    // MARK: - Public Method
    func location(at index: Int) -> LocationModel? {
        guard index < numberOfLocations else {
            return nil
        }
        
        return locations[index]
    }
    
    func locationViewModel(at index: Int) -> LocationProtocol? {
        guard let location = location(at: index) else { return nil }
        
        return LocationViewModel(location: location.location, locationText: location.name)
    }
    
}

// MARK: - Private Method
private extension AddLocationViewModel {
    func geocode(address: String?) {
        guard let address = address else {
            locations = []
            
            return
        }
        isQuerying = true
        
        geocoder.geocodeAddressString(address) { [weak self] (placemarks, error) in
            DispatchQueue.main.async {
                self?.processResponse(with: placemarks, error: error)
                self?.isQuerying = false
            }
        }
    }
    
    func processResponse(with placemarks: [CLPlacemark]?, error: Error?) {
        if let error = error {
            print("Cannot handle Geocode Address! \(error)")
        } else if let results = placemarks {
            locations = results.compactMap { result -> LocationModel? in
                guard let name = result.name else { return nil }
                guard let location = result.location else { return nil }
                
                return LocationModel(name: name,
                                     latitude: location.coordinate.latitude,
                                     longitude: location.coordinate.longitude)
            }
            
        }
    }
}
