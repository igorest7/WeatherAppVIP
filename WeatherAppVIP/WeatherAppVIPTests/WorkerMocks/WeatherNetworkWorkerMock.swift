//
//  WeatherNetworkWorkerMock.swift
//  WeatherAppVIPTests
//
//  Created by Igor Nakonetsnoi on 28/03/2019.
//  Copyright © 2019 Igor Nakonetsnoi. All rights reserved.
//

@testable import WeatherAppVIP

class WeatherNetworkWorkerMock: WeatherNetworkWorker {
	let manager: NetworkRequestManager = NetworkRequestManagerImplementation()

	var getCurrentWeatherInCityCalled = false
	var getCurrentWeatherInCityRequest: String?
	var getCurrentWeatherInCityResult: Either<WeatherReading, Error> = .left(WeatherReading.generic())

	func getCurrentWeatherInCity(_ city: String, completion: @escaping (Either<WeatherReading, Error>) -> Void) {
		getCurrentWeatherInCityCalled = true
		getCurrentWeatherInCityRequest = city
		completion(getCurrentWeatherInCityResult)
	}
}
