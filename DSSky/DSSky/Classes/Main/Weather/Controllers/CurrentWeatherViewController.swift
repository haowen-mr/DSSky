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
    
    
    // MARK: - Action
    @IBAction func locationBtnClick() {
        delegate?.locationClick(vc: self)
    }
    
    @IBAction func settingsBtnClick() {
        delegate?.settingsClick(vc: self)
    }
    
    
}

// MARK: - Private Method
private extension CurrentWeatherViewController {
    func updateView() {
        activityIndictorView.stopAnimating()
        
        if let vm = viewModel, vm.isUpdateReady {
            weatherContainerView.isHidden = false
            
            (weatherContainerView as! CurrentWeatherView).showData(vm)
        } else {
            loadingFailedLabel.isHidden = false
            loadingFailedLabel.text = "获取天气数据失败~"
        }
    }
    
    func setupUI() {
        
    }
}
