//
//  LocationViewController.swift
//  DSSky
//
//  Created by 左得胜 on 2019/3/1.
//  Copyright © 2019 左得胜. All rights reserved.
//

import UIKit
import CoreLocation

protocol LocationViewControllerDelegate: class {
    func controller(_ controller: LocationViewController, didSelectWith locaion: CLLocation)
}

class LocationViewController: UITableViewController {
    // MARK: - Property
    // MARK: Public
    weak var delegate: LocationViewControllerDelegate?
    
    var currentLocation: CLLocation?
    
    var favorites = SettingTool.loadLocations()
    
    var hasFavourites: Bool {
        return favorites.count > 0
    }
    
    // MARK: Private
    
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier else { return }
        switch identifier {
        case "segueAddLocation":
            guard let destination = segue.destination as? AddLocationViewController else {
                fatalError(kTitle.guardError)
            }
            destination.delegate = self
        default:
            break
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return Section.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let section = Section(rawValue: section) else { fatalError(kTitle.guardError) }
        switch section {
        case .current:
            return 1
        case .favorite:
            return max(favorites.count, 1)
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let section = Section(rawValue: section) else { fatalError(kTitle.guardError) }
        return section.title
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let section = Section(rawValue: indexPath.section) else { fatalError(kTitle.guardError) }
        let cell = tableView.dequeueReusableCell(LocationTableViewCell.self, for: indexPath)
        
        var vm: LocationViewModel?
        switch section {
        case .current:
            if let currentLocation = currentLocation {
                vm = LocationViewModel(location: currentLocation, locationText: nil)
            } else {
                cell.label.text = "未知"
            }
        case .favorite:
            if favorites.count > 0 {
                let fav: LocationModel = favorites[indexPath.row]
                vm = LocationViewModel(location: fav.location, locationText: fav.name)
            } else {
                cell.label.text = "没有收藏的城市~"
            }
        }
        if let vm = vm {
            cell.showData(vm)
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        guard let section = Section(rawValue: indexPath.section) else { fatalError(kTitle.guardError) }
        switch section {
        case .current: return false
        case .favorite: return hasFavourites
        }
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        SettingTool.removeLocation(at: indexPath.row)
        favorites.remove(at: indexPath.row)
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let section = Section(rawValue: indexPath.section) else { fatalError(kTitle.guardError) }
        
        var location: CLLocation?
        switch section {
        case .current:
            if let currentLocation = currentLocation {
                location = currentLocation
            }
        case .favorite:
            if hasFavourites {
                location = favorites[indexPath.row].location
            }
        }
        
        if let location = location {
            delegate?.controller(self, didSelectWith: location)
            dismiss(animated: true, completion: nil)
        }
    }
    
    // MARK: - Action
    @IBAction func unwindToLocationViewController(segue: UIStoryboardSegue) {
        
    }
}

// MARK: - Private Method
private extension LocationViewController {
    private enum Section: Int {
        case current
        case favorite
        
        var title: String {
            switch self {
            case .current:
                return "当前城市"
            case .favorite:
                return "收藏的城市"
            }
        }
        
        static var count: Int {
            return Section.favorite.rawValue + 1
        }
    }
    
    func setupUI() {
        
    }
}

// MARK: - AddLocationViewControllerDelegate
extension LocationViewController: AddLocationViewControllerDelegate {
    func controller(_ controller: AddLocationViewController, didAddWith location: LocationModel) {
        SettingTool.addLocation(location)
        
        favorites.append(location)
        
        tableView.reloadData()
    }
}
