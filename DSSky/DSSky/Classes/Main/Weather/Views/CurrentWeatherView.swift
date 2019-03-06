//
//  CurrentWeatherView.swift
//  DSSky
//
//  Created by 左得胜 on 2019/2/22.
//  Copyright © 2019 左得胜. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class CurrentWeatherView: UIView {
    // MARK: - Property
    // MARK: Public
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var weatherIV: UIImageView!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var summaryLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    private let bag = DisposeBag()
    
    // MARK: Private
    
    
    // MARK: - LifeCycle
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    // MARK: - Publid Method
    func showData(_ vm: SharedSequence<DriverSharingStrategy, (CurrentLocationViewModel, CurrentWeatherViewModel)>) {
        vm.map { $0.0.city }.drive(locationLabel.rx.text).disposed(by: bag)
        vm.map { $0.1.temperature }.drive(temperatureLabel.rx.text).disposed(by: bag)
        vm.map { $0.1.weatherModel.currently.icon }.drive(weatherIV.rx.image).disposed(by: bag)
        vm.map { $0.1.weatherModel.currently.humidity }.drive(humidityLabel.rx.text).disposed(by: bag)
        vm.map { $0.1.weatherModel.currently.summary }.drive(summaryLabel.rx.text).disposed(by: bag)
        vm.map { $0.1.time }.drive(dateLabel.rx.text).disposed(by: bag)
        
//        locationLabel.text = model.location.city
//        temperatureLabel.text = model.weather.temperature
//        weatherIV.image = model.weather.weatherModel.currently.icon
//        humidityLabel.text = model.weather.weatherModel.currently.humidity
//        summaryLabel.text = model.weather.weatherModel.currently.summary
//        dateLabel.text = model.weather.time
    }
    
    // MARK: - Action
    
}

// MARK: - Private Method
private extension CurrentWeatherView {
    func setupUI() {
        
    }
}
