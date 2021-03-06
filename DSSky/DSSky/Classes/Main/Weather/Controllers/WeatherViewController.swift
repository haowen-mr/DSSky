//
//  WeatherViewController.swift
//  DSSky
//
//  Created by 左得胜 on 2019/2/21.
//  Copyright © 2019 左得胜. All rights reserved.
//

import UIKit
import CoreLocation
import AMapSearchKit
import RxSwift

class WeatherViewController: UIViewController {
    // MARK: - Property
    // MARK: Public
    var currentWeatherViewController: CurrentWeatherViewController!
    var weekWeatherViewController: WeekWeatherViewController!
    
    
    // MARK: Private
    private var currentLocation: CLLocation? {
        didSet {
            fetchWeather()
            fetchCity()
        }
    }
    /// 懒加载搜索
    private lazy var search: AMapSearchAPI = {
        let search: AMapSearchAPI = AMapSearchAPI()
        search.delegate = self
        return search
    }()
    private let bag = DisposeBag()
        
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
            destination.delegate = self
            currentWeatherViewController = destination
        case "segueWeekWeather":
            guard let destination = segue.destination as? WeekWeatherViewController else {
                fatalError("Invalid destination view controller!")
            }
            weekWeatherViewController = destination
        default:
            break
        }
    }
    
    // MARK: - Public Method
    /// 获取天气数据
    func fetchWeather() {
        guard let location = currentLocation else { return }
        let lat = location.coordinate.latitude
        let lon = location.coordinate.longitude
        
        let weather = NetworkTool.shared.request(lat: lat, lon: lon)
            //            .subscribe(onNext: { (weather) in
            //            self.currentWeatherViewController.weatherVM.accept(CurrentWeatherViewModel(weatherModel: weather))
            //            self.weekWeatherViewController.viewModel = WeekWeatherViewModel(weekWeatherModels: weather.daily.data)
            //        })
            //        .disposed(by: bag)
            .share(replay: 1, scope: .whileConnected)
            .observeOn(MainScheduler.instance)
        
        weather.map { CurrentWeatherViewModel(weatherModel: $0) }
            .bind(to: currentWeatherViewController.weatherVM)
            .disposed(by: bag)
        
        weather.map { WeekWeatherViewModel(weekWeatherModels: $0.daily.data) }
            .subscribe(onNext: { self.weekWeatherViewController.viewModel = $0 })
            .disposed(by: bag)
    }
    
    func fetchCity() {
        guard let location = currentLocation else { return }
        
        let request = AMapReGeocodeSearchRequest()
        request.location = AMapGeoPoint.location(withLatitude: CGFloat(location.coordinate.latitude), longitude: CGFloat(location.coordinate.longitude))
        
        search.aMapReGoecodeSearch(request)
    }
    
    // MARK: - Action
    @objc private func appDidBecomeActive() {
        requestLocation()
    }
    
    @IBAction func unwindToRootViewController(
        segue: UIStoryboardSegue) {
        
    }
}

// MARK: - Private Method
private extension WeatherViewController {
    /// 通知设置
    func setupNoti() {
        kNotiCenter.addObserver(self, selector: #selector(appDidBecomeActive), name: UIApplication.didBecomeActiveNotification, object: nil)
    }
    
    /// 单次请求位置
    func requestLocation() {
        AMapLocationTool.shared.requestLocation(isReGeocode: false) { [weak self] (location, _, error) in
            guard let `self` = self else { return }
            if let error = error {
                HUD.show(.text, message: error.localizedDescription)
                self.currentWeatherViewController.locationVM.accept(.invalid)
            } else if let location = location {
                self.currentLocation = location
            }
            
        }
    }
    
    func updateCurrent(with location: LocationModel) {
        currentWeatherViewController.locationVM.accept(CurrentLocationViewModel(location: location))
    }
    
    func setupUI() {
        
    }
}

extension WeatherViewController: AMapSearchDelegate {
    func onReGeocodeSearchDone(_ request: AMapReGeocodeSearchRequest!, response: AMapReGeocodeSearchResponse!) {
        if response.regeocode == nil { return }
        
        let city = response.regeocode.addressComponent.city
        let location = LocationModel.init(name: city ?? "", latitude: Double(request.location!.latitude), longitude: Double(request.location!.longitude))
        updateCurrent(with: location)
    }
}

// MARK: - CurrentWeatherViewControllerDelegate
extension WeatherViewController: CurrentWeatherViewControllerDelegate {
    func locationClick(vc: CurrentWeatherViewController, didSelectWith location: CLLocation) {
        currentWeatherViewController.weatherVM.accept(.empty)
        currentWeatherViewController.locationVM.accept(.empty)
        currentLocation = location
    }
    
    func settingsClick(vc: CurrentWeatherViewController) {
        QLPlusLine()
        currentWeatherViewController.updateView()
        weekWeatherViewController.updateView()
    }
    
}

