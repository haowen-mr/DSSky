//
//  WeatherBaseViewController.swift
//  DSSky
//
//  Created by 左得胜 on 2019/2/21.
//  Copyright © 2019 左得胜. All rights reserved.
//

import UIKit

class WeatherBaseViewController: UIViewController {
    // MARK: - Property
    // MARK: Public
    
    @IBOutlet weak var weatherContainerView: UIView!
    @IBOutlet weak var loadingFailedLabel: UILabel!
    @IBOutlet weak var activityIndictorView: UIActivityIndicatorView!
    
    // MARK: Private
    
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    
    // MARK: - Action
    
}

// MARK: - Private Method
private extension WeatherBaseViewController {
    func setupUI() {
        weatherContainerView.isHidden = true
        loadingFailedLabel.isHidden = true
        
        activityIndictorView.startAnimating()
        activityIndictorView.hidesWhenStopped = true
    }
}

