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
    
    // MARK: - Public Method
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
    
    
    // MARK: - Action
    
}

// MARK: - Private Method
private extension WeekWeatherViewController {
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
        if let vm = viewModel?.viewModel(for: indexPath.row) {
            cell.showData(vm)
        }
        return cell
    }
}
