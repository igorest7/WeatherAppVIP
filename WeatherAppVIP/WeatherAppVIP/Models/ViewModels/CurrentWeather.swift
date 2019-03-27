//
//  CurrentWeather.swift
//  WeatherAppVIP
//
//  Created by Igor Nakonetsnoi on 27/03/2019.
//  Copyright © 2019 Igor Nakonetsnoi. All rights reserved.
//

enum CurrentWeather {
	struct Response {
		var weather: WeatherReading
	}

	struct ViewModel {
		var temperature: String
		var feelTemperature: String
		var cloudCover: String
		var condition: String
	}
}
