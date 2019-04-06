//
//  MainWeatherPresenter.swift
//
//  Created by Igor Nakonetsnoi on 22/03/2019.
//  Copyright © 2019 Igor Nakonetsnoi. All rights reserved.

import Foundation

final class MainWeatherPresenter {
    weak private var output: MainWeatherPresenterOutput!
    
    init(output: MainWeatherPresenterOutput) {
        self.output = output
    }
}

// MARK: - MainWeatherPresenterInput
extension MainWeatherPresenter: MainWeatherPresenterInput {
	func receivedCurrentWeather(response: CurrentWeather.Response) {
		let temperatureString = String(format: "main.weather.temperature.label".localized, response.weather.temp)
		let feelTemperatureString = String(format: "main.weather.feel.temperature.label".localized, response.weather.feelTemp)
		let cloudCoverString = String(format: "main.weather.cloud.cover.label".localized, response.weather.cloudCover)
		let viewModel = CurrentWeather.ViewModel(temperature: temperatureString,
												 feelTemperature: feelTemperatureString,
												 cloudCover: cloudCoverString,
												 condition: response.weather.conditionText)
		output.presentWeather(viewModel: viewModel)
	}

	func receivedError(response: Alert.Response) {
		output.showAlertWith(title: nil, message: response.error.localizedDescription)
	}
}
