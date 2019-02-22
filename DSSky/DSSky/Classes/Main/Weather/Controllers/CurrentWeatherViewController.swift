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
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var weatherIV: UIImageView!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var summaryLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    
    // MARK: - Action
    @IBAction func locationBtnClick() {
        print(#file, #line)
    }
    
    @IBAction func settingsBtnClick() {
        
    }
    
    
}

// MARK: - Private Method
private extension CurrentWeatherViewController {
    func updateView() {
        activityIndictorView.stopAnimating()
        
        if let model = viewModel, model.isUpdateReady {
            weatherContailerView.isHidden = false
            
            locationLabel.text = model.city
            temperatureLabel.text = model.temperature
            weatherIV.image = model.weatherIcon
            humidityLabel.text = model.humidity
            summaryLabel.text = model.summary
            dateLabel.text = model.date
        } else {
            loadingFailedLabel.isHidden = false
            loadingFailedLabel.text = "获取天气数据失败~"
        }
    }
    
    func setupUI() {
        
    }
}
