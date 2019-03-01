//
//  WeekWeatherViewModel.swift
//  DSSky
//
//  Created by 左得胜 on 2019/2/28.
//  Copyright © 2019 左得胜. All rights reserved.
//

import UIKit

struct WeekWeatherViewModel {
    let weekWeatherModels: [ForecastModel]
    
    private let dateFormatter = DateFormatter()
    
    
    
    var numberOfSections: Int {
        return 1
    }
    
    var numberOfDays: Int {
        return weekWeatherModels.count
    }
    
    func viewModel(for index: Int) -> WeekWeatherDayViewModel {
        return WeekWeatherDayViewModel(weatherModel: weekWeatherModels[index])
    }
    
}
