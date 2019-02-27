//
//  WeatherViewController.swift
//  DSSky
//
//  Created by 左得胜 on 2019/2/21.
//  Copyright © 2019 左得胜. All rights reserved.
//

import UIKit
import CoreLocation

class WeatherViewController: UIViewController {
    // MARK: - Property
    // MARK: Public
    var currentWeatherViewController: CurrentWeatherViewController!
    var weekWeatherViewController: WeekWeatherViewController!
    
    
    // MARK: Private
        
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupNoti()
    }
    
    deinit {
        kNotiCenter.removeObserver(self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier else { return }
        
        switch identifier {
        case "segueCurrentWeather":
            guard let destination = segue.destination as? CurrentWeatherViewController else {
                fatalError("Invalid destination view controller!")
            }
            destination.viewModel = CurrentWeatherViewModel()
            destination.delegate = self
            currentWeatherViewController = destination
            
        default:
            break
        }
    }
    
    // MARK: - Action
    @objc private func appDidBecomeActive() {
        requestLocation()
    }
}

// MARK: - Private Method
private extension WeatherViewController {
    
    /// 获取天气数据
    func fetchWeather(_ currentLocation: CLLocation) {
        let lat = currentLocation.coordinate.latitude
        let lon = currentLocation.coordinate.longitude
        NetworkTool.shared.request(lat: lat, lon: lon) { [weak self] (model, error) in
            guard let `self` = self else { return }
            if let error = error {
                HUD.show(.text, message: error.localizedDescription)
            }
            else if let model = model {
                self.currentWeatherViewController.viewModel?.weather = model
            }
        }
    }
    
    /// 通知设置
    func setupNoti() {
        kNotiCenter.addObserver(self, selector: #selector(appDidBecomeActive), name: UIApplication.didBecomeActiveNotification, object: nil)
    }
    
    /// 单次请求位置
    func requestLocation() {
        AMapLocationTool.shared.requestLocation(isReGeocode: true) { [weak self] (location, regeocoder, error) in
            guard let `self` = self else { return }
            if let error = error {
                HUD.show(.text, message: error.localizedDescription)
            }
            else if let location = location {
                self.fetchWeather(location)
                
                if let regeocoder = regeocoder {// 反地理编码
                    let location = LocationModel.init(name: regeocoder.city, latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
                    self.currentWeatherViewController.viewModel?.location = location
                }
            }
            
        }
    }
    
    func setupUI() {
        
    }
}

extension WeatherViewController: CurrentWeatherViewControllerDelegate {
    func locationClick(vc: CurrentWeatherViewController) {
        QLPlusLine()
    }
    
    func settingsClick(vc: CurrentWeatherViewController) {
        QLPlusLine()
    }
    
}
