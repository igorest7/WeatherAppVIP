//
//  MainWeatherContracts.swift
//
//  Created by Igor Nakonetsnoi on 22/03/2019.
//  Copyright © 2019 Igor Nakonetsnoi. All rights reserved.

import Foundation

protocol MainWeatherConfigurator {
    func configureWith(viewController: MainWeatherViewController)
}

protocol MainWeatherRouter: ViewRouter {
}

// MARK: - Outputs
protocol MainWeatherViewOutput {
	func viewDidLoad()
}

protocol MainWeatherInteractorOutput {
	func receivedCurrentWeather(response: CurrentWeather.Response)
}

protocol MainWeatherPresenterOutput: class {
	func presentWeather(viewModel: CurrentWeather.ViewModel)
}

// MARK: - Inputs
protocol MainWeatherViewInput: MainWeatherPresenterOutput {
    
}

protocol MainWeatherInteractorInput: MainWeatherViewOutput {
    
}

protocol MainWeatherPresenterInput: MainWeatherInteractorOutput {
    
}
