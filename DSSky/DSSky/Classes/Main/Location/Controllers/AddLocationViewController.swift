//
//  AddLocationViewController.swift
//  DSSky
//
//  Created by 左得胜 on 2019/3/1.
//  Copyright © 2019 左得胜. All rights reserved.
//

import UIKit
import CoreLocation

protocol AddLocationViewControllerDelegate: class {
    func controller(_ controller: AddLocationViewController, didAddWith location: LocationModel)
}

class AddLocationViewController: UITableViewController {
    // MARK: - Property
    // MARK: Public
    weak var delegate: AddLocationViewControllerDelegate?
    
    // MARK: Private
    @IBOutlet weak var searchBar: UISearchBar!
    private var locations: [LocationModel] = []
    private lazy var geocoder = CLGeocoder()
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        searchBar.becomeFirstResponder()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return locations.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(LocationTableViewCell.self, for: indexPath)
        
        let location = locations[indexPath.row]
        let vm = LocationViewModel.init(location: location.location, locationText: location.name)
        cell.showData(vm)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let location = locations[indexPath.row]
        delegate?.controller(self, didAddWith: location)
        navigationController?.popViewController(animated: true)
    }
    
    
    // MARK: - Action
    
}

// MARK: - Private Method
private extension AddLocationViewController {
    func geocode(address: String?) {
        guard let address = address else {
            locations = []
            tableView.reloadData()
            
            return
        }
        
        geocoder.geocodeAddressString(address) { [weak self] (placemarks, error) in
            DispatchQueue.main.async {
                self?.processResponse(with: placemarks, error: error)
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
            
            tableView.reloadData()
        }
    }
    
    func setupUI() {
    }
}

extension AddLocationViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        geocode(address: searchBar.text)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        locations = []
        tableView.reloadData()
    }
}
