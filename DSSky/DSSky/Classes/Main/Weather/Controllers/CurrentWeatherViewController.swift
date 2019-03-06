//
//  CurrentWeatherViewController.swift
//  DSSky
//
//  Created by 左得胜 on 2019/2/21.
//  Copyright © 2019 左得胜. All rights reserved.
//

import UIKit
import CoreLocation
import RxSwift
import RxCocoa

protocol CurrentWeatherViewControllerDelegate: class {
    func locationClick(vc: CurrentWeatherViewController, didSelectWith location: CLLocation)
    func settingsClick(vc: CurrentWeatherViewController)
}

class CurrentWeatherViewController: WeatherBaseViewController {
    // MARK: - Property
    // MARK: Public
    var weatherVM: BehaviorRelay<CurrentWeatherViewModel> = BehaviorRelay(value: .empty)
    var locationVM: BehaviorRelay<CurrentLocationViewModel> = BehaviorRelay(value: .empty)
    
    weak var delegate: CurrentWeatherViewControllerDelegate?
    
    // MARK: Private
    private let bag = DisposeBag()
    
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
        let combined = Observable.combineLatest(locationVM, weatherVM, resultSelector: { ($0, $1) })
        .share(replay: 1, scope: .whileConnected)
        let viewModel = combined
            .filter { self.shouldDisplayWeatherContainer(locationVM: $0.0, weatherVM: $0.1) }
            .asDriver(onErrorJustReturn: (.empty, .empty))
        
        combined.map { self.shouldHideWeatherContainer(locationVM: $0.0
            , weatherVM: $0.1) }
        .asDriver(onErrorJustReturn: true)
        .drive(weatherContainerView.rx.isHidden)
        .disposed(by: bag)
        
        combined.map { self.shouldHideActivityIndicator(locationVM: $0.0, weatherVM: $0.1) }
        .asDriver(onErrorJustReturn: true)
        .drive(activityIndictorView.rx.isHidden)
        .disposed(by: bag)
        
        combined.map { self.shouldAnimateActivityIndicator(locationVM: $0.0, weatherVM: $0.1) }
            .asDriver(onErrorJustReturn: true)
            .drive(activityIndictorView.rx.isAnimating)
            .disposed(by: bag)
        
        let errorCond = combined.map { self.shouldDisplayErrorPrompt(locationVM: $0.0, weatherVM: $0.1) }
        .asDriver(onErrorJustReturn: true)
        
        errorCond.map { !$0 }.drive(retryBtn.rx.isHidden).disposed(by: bag)
        errorCond.map { !$0 }.drive(loadingFailedLabel.rx.isHidden).disposed(by: bag)
        errorCond.map { _ in return "Opps! Load Location/Weather failed!" }.drive(loadingFailedLabel.rx.text).disposed(by: bag)
        
        retryBtn.rx.tap.subscribe(onNext: { _ in
            self.weatherVM.accept(.empty)
            self.locationVM.accept(.empty)
            
            (self.parent as? WeatherViewController)?.fetchCity()
            (self.parent as? WeatherViewController)?.fetchWeather()
        })
        .disposed(by: bag)
        
        (self.weatherContainerView as! CurrentWeatherView).showData(viewModel)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier else { return }
        switch identifier {
        case "segueSettings":
            guard let nav = segue.destination as? UINavigationController,
                let destination = nav.topViewController as? SettingsViewController else {
                    fatalError("Invalid destination view controller!")
            }
            destination.delegate = self
        case "sugueLocation":
            guard let nav = segue.destination as? UINavigationController,
                let destination = nav.topViewController as? LocationViewController else {
                    fatalError("Invalid destination view controller!")
            }
            destination.delegate = self
            destination.currentLocation = locationVM.value.location.location
        default:
            break
        }
    }
    
    // MARK: - Public Method
    func updateView() {
        weatherVM.accept(weatherVM.value)
        locationVM.accept(locationVM.value)
    }
    
    // MARK: - Action
        
}

// MARK: - Private Method
private extension CurrentWeatherViewController {
    func shouldDisplayWeatherContainer(locationVM: CurrentLocationViewModel,
                                       weatherVM: CurrentWeatherViewModel) -> Bool {
        return !locationVM.isEmpty && !locationVM.isInvalid &&
            !weatherVM.isEmpty && !weatherVM.isInvalid
    }
    
    func shouldHideWeatherContainer(locationVM: CurrentLocationViewModel,
                                    weatherVM: CurrentWeatherViewModel) -> Bool {
        return locationVM.isEmpty || locationVM.isInvalid ||
            weatherVM.isEmpty || weatherVM.isInvalid
    }
    
    func shouldHideActivityIndicator(locationVM: CurrentLocationViewModel,
                                     weatherVM: CurrentWeatherViewModel) -> Bool {
        return (!locationVM.isEmpty && !weatherVM.isEmpty) ||
            locationVM.isInvalid || weatherVM.isInvalid
    }
    
    func shouldAnimateActivityIndicator(locationVM: CurrentLocationViewModel,
                                        weatherVM: CurrentWeatherViewModel) -> Bool {
        return locationVM.isEmpty || weatherVM.isEmpty
    }
    
    func shouldDisplayErrorPrompt(locationVM: CurrentLocationViewModel,
                                  weatherVM: CurrentWeatherViewModel) -> Bool {
        return locationVM.isInvalid || weatherVM.isInvalid
    }
    
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

// MARK: - LocationViewControllerDelegate
extension CurrentWeatherViewController: LocationViewControllerDelegate {
    func controller(_ controller: LocationViewController, didSelectWith locaion: CLLocation) {
        delegate?.locationClick(vc: self, didSelectWith: locaion)
    }
}
