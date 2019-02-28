//
//  CurrentWeatherViewController.swift
//  DSSky
//
//  Created by 左得胜 on 2019/2/21.
//  Copyright © 2019 左得胜. All rights reserved.
//

import UIKit

protocol CurrentWeatherViewControllerDelegate: class {
    func locationClick(vc: CurrentWeatherViewController)
    func settingsClick(vc: CurrentWeatherViewController)
}

class CurrentWeatherViewController: WeatherBaseViewController {
    // MARK: - Property
    // MARK: Public
    var viewModel: CurrentWeatherViewModel? {
        didSet {
            DispatchQueue.main.async {
                self.updateView()
            }
        }
    }
    
    weak var delegate: CurrentWeatherViewControllerDelegate?
    
    // MARK: Private
    
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier else { return }
        if identifier == "segueSettings" {
            guard let nav = segue.destination as? UINavigationController,
                let destination = nav.topViewController as? SettingsViewController else {
                    fatalError("Invalid destination view controller!")
            }
            destination.delegate = self
        }
    }
    
    // MARK: - Public Method
    func updateView() {
        activityIndictorView.stopAnimating()
        
        if let vm = viewModel, vm.isUpdateReady {
            weatherContainerView.isHidden = false
            
            (weatherContainerView as! CurrentWeatherView).showData(vm)
        } else {
            loadingFailedLabel.isHidden = false
            loadingFailedLabel.text = kTitle.loadError
        }
    }
    
    // MARK: - Action
    @IBAction func locationBtnClick() {
        delegate?.locationClick(vc: self)
    }
        
}

// MARK: - Private Method
private extension CurrentWeatherViewController {
    func setupUI() {
        
    }
}

// MARK: - SettingsViewControllerDelagete
extension CurrentWeatherViewController: SettingsViewControllerDelagete {
    func controllerDidChangeTimeType(_ controller: SettingsViewController) {
        reloadUI()
    }
    
    func controllerDidChangeTemperatureType(_ controller: SettingsViewController) {
        reloadUI()
    }
    
    private func reloadUI() {
        delegate?.settingsClick(vc: self)
    }
}
