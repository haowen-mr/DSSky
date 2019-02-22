//
//  CurrentWeatherViewController.swift
//  DSSky
//
//  Created by 左得胜 on 2019/2/21.
//  Copyright © 2019 左得胜. All rights reserved.
//

import UIKit

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
    
    // MARK: Private
    
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    
    // MARK: - Action
    @IBAction func locationBtnClick() {
        QLPlusLine()
    }
    
    @IBAction func settingsBtnClick() {
        QLPlusLine()
    }
    
    
}

// MARK: - Private Method
private extension CurrentWeatherViewController {
    func updateView() {
        activityIndictorView.stopAnimating()
        
        if let model = viewModel, model.isUpdateReady {
            weatherContailerView.isHidden = false
            
            (weatherContailerView as! CurrentWeatherView).showData(model)
        } else {
            loadingFailedLabel.isHidden = false
            loadingFailedLabel.text = "获取天气数据失败~"
        }
    }
    
    func setupUI() {
        
    }
}
