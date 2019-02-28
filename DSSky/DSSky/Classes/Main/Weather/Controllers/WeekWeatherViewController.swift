//
//  WeekWeatherViewController.swift
//  DSSky
//
//  Created by 左得胜 on 2019/2/21.
//  Copyright © 2019 左得胜. All rights reserved.
//

import UIKit

class WeekWeatherViewController: WeatherBaseViewController {
    // MARK: - Property
    // MARK: Public
    var viewModel: WeekWeatherViewModel? {
        didSet {
            DispatchQueue.main.async {
                self.updateView()
            }
        }
    }
    
    // MARK: Private
    @IBOutlet weak var tableView: UITableView!
    
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    
    // MARK: - Action
    
}

// MARK: - Private Method
private extension WeekWeatherViewController {
    func updateView() {
        activityIndictorView.stopAnimating()
        
        if let _ = viewModel {
            weatherContainerView.isHidden = false
            tableView.reloadData()
        } else {
            loadingFailedLabel.isHidden = false
            loadingFailedLabel.text = kTitle.loadError
        }
    }
    
    func setupUI() {
        
    }
}

extension WeekWeatherViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        guard let vm = viewModel else { return 0 }
        return vm.numberOfSections
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let vm = viewModel else { return 0 }
        return vm.numberOfDays
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(WeekWeatherTableViewCell.self, for: indexPath)
        if let vm = viewModel {
            cell.weekLabel.text = vm.week(for: indexPath.row)
            cell.dateLabel.text = vm.date(for: indexPath.row)
            cell.temperatureLabel.text = vm.temperature(for: indexPath.row)
            cell.weatherIV.image = vm.weatherIcon(for: indexPath.row)
            cell.humidityLabel.text = vm.humidity(for: indexPath.row)
        }
        return cell
    }
}
