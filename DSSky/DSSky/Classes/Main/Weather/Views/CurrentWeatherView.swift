//
//  CurrentWeatherView.swift
//  DSSky
//
//  Created by 左得胜 on 2019/2/22.
//  Copyright © 2019 左得胜. All rights reserved.
//

import UIKit

class CurrentWeatherView: UIView {
    // MARK: - Property
    // MARK: Public
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var weatherIV: UIImageView!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var summaryLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    
    // MARK: Private
    
    
    // MARK: - LifeCycle
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    // MARK: - Publid Method
    func showData(_ model: CurrentWeatherProtocol) {
        locationLabel.text = model.locationModel.name
        temperatureLabel.text = model.temperature
        weatherIV.image = model.weatherModel.currently.icon
        humidityLabel.text = model.weatherModel.currently.humidity
        summaryLabel.text = model.weatherModel.currently.summary
        dateLabel.text = model.time
    }
    
    // MARK: - Action
    
}

// MARK: - Private Method
private extension CurrentWeatherView {
    func setupUI() {
        
    }
}
