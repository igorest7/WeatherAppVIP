//
//  WeatherNetworkWorker.swift
//  WeatherAppVIP
//
//  Created by Igor Nakonetsnoi on 26/03/2019.
//  Copyright © 2019 Igor Nakonetsnoi. All rights reserved.
//

import Foundation

protocol WeatherNetworkWorker: NetworkService {
	func getCurrentWeatherInCity(_ city: String, completion: @escaping (Either<WeatherReading, Error>) -> Void)
}

class WeatherNetworkWorkerImplementation: WeatherNetworkWorker {
	let manager: NetworkRequestManager = NetworkRequestManagerImplementation()

	func getCurrentWeatherInCity(_ city: String, completion: @escaping (Either<WeatherReading, Error>) -> Void) {
		manager.cancel()
		manager.request(CurrentWeatherNetworkRouter.getCurrentWeatherInCity(city)) { result in
			DispatchQueue.main.async {
				switch result {
				case .left(let data):
					do {
						let weather = try JSONDecoder().decode(WeatherReading.self, from: data)
						completion(.left(weather))
					}catch {
						completion(.right("network.response.invalid.response".localized))
					}

				case .right(let error): completion(.right(error))
				}
			}
		}
	}
}

