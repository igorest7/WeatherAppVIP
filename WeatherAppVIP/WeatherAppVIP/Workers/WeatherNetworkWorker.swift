//
//  WeatherNetworkWorker.swift
//  WeatherAppVIP
//
//  Created by Igor Nakonetsnoi on 26/03/2019.
//  Copyright © 2019 Igor Nakonetsnoi. All rights reserved.
//

import Foundation

protocol WeatherNetworkWorker: NetworkService {
	func getCurrentWeatherInCity(_ city: String, completion: @escaping (Either<String, Error>) -> Void)
}

struct WeatherNetworkWorkerImplementation: WeatherNetworkWorker {
	let manager: NetworkRequestManager = NetworkRequestManagerImplementation()

	func getCurrentWeatherInCity(_ city: String, completion: @escaping (Either<String, Error>) -> Void) {
		manager.cancel()
		manager.request(CurrentWeatherNetworkRouter.getCurrentWeatherInCity(city)) { result in
			switch result {
			case .left(let data):
				completion(.left("completed"))
			case .right(let error): completion(.right(error))
			}
		}
	}
}

