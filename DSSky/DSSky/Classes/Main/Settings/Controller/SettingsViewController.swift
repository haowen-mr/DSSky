//
//  SettingsViewController.swift
//  DSSky
//
//  Created by 左得胜 on 2019/2/28.
//  Copyright © 2019 左得胜. All rights reserved.
//

import UIKit

protocol SettingsViewControllerDelagete {
    func controllerDidChangeTimeType(_ controller: SettingsViewController)
    func controllerDidChangeTemperatureType(_ controller: SettingsViewController)
}

class SettingsViewController: UITableViewController {
    // MARK: - Property
    // MARK: Public
    var delegate: SettingsViewControllerDelagete?
    
    // MARK: Private
    
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return Section.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let section = Section(rawValue: section) else {
            fatalError(kTitle.guardError)
        }
        
        return section.numberOfRows
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if (section == 0){
            return "Date format"
        }
        return "Temperature unit"
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(SettingsTableViewCell.self, for: indexPath)
        guard let section = Section(rawValue: indexPath.section) else { fatalError(kTitle.guardError) }
        
        switch section {
        case .date:
            cell.label.text = (indexPath.row == 0) ?
                "Fri, 01 December" : "F, 12/01"
            let timeMode = SettingTool.dateType()
            
            if indexPath.row == timeMode.rawValue {
                cell.accessoryType = .checkmark
            }
            else {
                cell.accessoryType = .none
            }
        case .temperature:
            cell.label.text = (indexPath.row == 0) ?
                "Celcius" : "Fahrenheit"
            let temperatureNotation = SettingTool.temperatureType()
            
            if indexPath.row == temperatureNotation.rawValue {
                cell.accessoryType = .checkmark
            } else {
                cell.accessoryType = .none
            }
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        guard let section = Section(rawValue: indexPath.section) else { fatalError(kTitle.guardError) }
        
        switch section {
        case .date:
            let dateMode = SettingTool.dateType()
            guard indexPath.row != dateMode.rawValue else { return }
            
            if let newMode = DateType(rawValue: indexPath.row) {
                SettingTool.setDateType(to: newMode)
            }
            
            delegate?.controllerDidChangeTimeType(self)
            
        case .temperature:
            let temperatureMode = SettingTool.temperatureType()
            guard indexPath.row != temperatureMode.rawValue else { return }
            
            if let newMode = TemperatureType(rawValue: indexPath.row) {
                SettingTool.setTemperatureType(to: newMode)
            }
            
            delegate?.controllerDidChangeTemperatureType(self)
        }
        
        let sections = IndexSet(integer: indexPath.section)
        tableView.reloadSections(sections, with: .none)
    }
    
    // MARK: - Action
    
}

// MARK: - Private Method
private extension SettingsViewController {
    enum Section: Int {
        case date
        case temperature
        
        var numberOfRows: Int {
            return 2
        }
        
        static var count: Int {
            return Section.temperature.rawValue + 1
        }
    }
    
    func setupUI() {
        
    }
}
