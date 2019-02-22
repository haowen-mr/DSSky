//
//  WeatherViewController.swift
//  DSSky
//
//  Created by 左得胜 on 2019/2/21.
//  Copyright © 2019 左得胜. All rights reserved.
//

import UIKit
import AMapLocationKit

class WeatherViewController: UIViewController {
    // MARK: - Property
    // MARK: Public
    
    
    // MARK: Private
    /// 懒加载地址
//    private lazy var locationMalager: CLLocation = {
//        <#statements#>
//        return <#value#>
//    }()
//    
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        kNotiCenter.addObserver(self, selector: #selector(appDidBecomeActive), name: UIApplication.didBecomeActiveNotification, object: nil)
    }
    
    deinit {
        kNotiCenter.removeObserver(self)
    }
    
    // MARK: - Action
    @objc private func appDidBecomeActive() {
        requestLocation()
    }
}

// MARK: - Private Method
private extension WeatherViewController {
    func requestLocation() {
        
    }
    
    func setupUI() {
        
    }
}
