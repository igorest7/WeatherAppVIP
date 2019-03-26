//
//  WeatherNetworkService.swift
//  WeatherAppVIP
//
//  Created by Igor Nakonetsnoi on 26/03/2019.
//  Copyright © 2019 Igor Nakonetsnoi. All rights reserved.
//

import Foundation

struct WeatherNetworkService: NetworkService {
	let manager: NetworkRequestManager = NetworkRequestManagerImplementation()

	func getCurrentWeatherInCity(_ city: String, completion: @escaping (Either<String, Error>) -> Void) {
		manager.cancel()
		manager.request(CurrentWeatherNetworkRouter.getCurrentWeatherInCity(city)) { (data, response, error) in
			print("data \(data), response \(response) error \(error)")
		}
	}
}

