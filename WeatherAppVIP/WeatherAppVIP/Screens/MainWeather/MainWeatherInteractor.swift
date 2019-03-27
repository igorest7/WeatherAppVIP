//
//  MainWeatherInteractor.swift
//
//  Created by Igor Nakonetsnoi on 22/03/2019.
//  Copyright © 2019 Igor Nakonetsnoi. All rights reserved.

final class MainWeatherInteractor {
    var output: MainWeatherInteractorOutput!
	var worker: WeatherNetworkWorker = WeatherNetworkWorkerImplementation()

    init(output: MainWeatherInteractorOutput) {
        self.output = output
    }
}

//MARK: - MainWeatherInteractorInput
extension MainWeatherInteractor: MainWeatherInteractorInput {
	func viewDidLoad() {
		worker.getCurrentWeatherInCity("London") { (result) in
			switch result {
			case .left(let weather):
				print("reading \(weather)")
			case .right(let error):
				print("error \(error)")
			}
		}
	}
}
