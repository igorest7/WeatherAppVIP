//
//  MainWeatherInteractor.swift
//
//  Created by Igor Nakonetsnoi on 22/03/2019.
//  Copyright © 2019 Igor Nakonetsnoi. All rights reserved.

import Foundation

final class MainWeatherInteractor {
    var output: MainWeatherInteractorOutput!
	var worker: WeatherNetworkWorker = WeatherNetworkWorkerImplementation()

    init(output: MainWeatherInteractorOutput) {
        self.output = output
    }
}

// MARK: - MainWeatherInteractorInput
extension MainWeatherInteractor: MainWeatherInteractorInput {
	func viewDidLoad() {
		worker.getCurrentWeatherInCity("London") { [weak self] (result) in
			switch result {
			case .left(let weather):
				let response = CurrentWeather.Response(weather: weather)
				self?.output.receivedCurrentWeather(response: response)
			case .right(let error):
				let response = Alert.Response(error: error)
				self?.output.receivedError(response: response)
			}
		}
	}
}
