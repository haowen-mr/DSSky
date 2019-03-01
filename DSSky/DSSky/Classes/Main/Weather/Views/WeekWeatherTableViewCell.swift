//
//  WeekWeatherTableViewCell.swift
//  DSSky
//
//  Created by 左得胜 on 2019/2/22.
//  Copyright © 2019 左得胜. All rights reserved.
//

import UIKit

class WeekWeatherTableViewCell: UITableViewCell {
    // MARK: - Property
    // MARK: Public
    static let reuseID = "WeekWeatherTableViewCell"
    
    // MARK: Private
    @IBOutlet weak var weekLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var weatherIV: UIImageView!
    @IBOutlet weak var humidityLabel: UILabel!
    
    
    // MARK: - LifeCycle
    
    
    // MARK: - Public Method
    func showData(_ vm: WeekWeatherDayProtocol) {
        weekLabel.text = vm.week
        dateLabel.text = vm.date
        temperatureLabel.text = vm.temperature
        weatherIV.image = vm.weatherIcon
        humidityLabel.text = vm.humidity
    }
    
    // MARK: - Action
    
}

// MARK: - Private Method
private extension WeekWeatherTableViewCell {
    
}
