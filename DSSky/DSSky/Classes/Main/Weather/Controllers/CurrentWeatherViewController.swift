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
    func setupUI() {
        
    }
}
