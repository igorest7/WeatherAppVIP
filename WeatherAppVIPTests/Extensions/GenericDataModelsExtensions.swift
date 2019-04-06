//
//  GenericDataModelsExtensions.swift
//  WeatherAppVIPTests
//
//  Created by Igor Nakonetsnoi on 28/03/2019.
//  Copyright © 2019 Igor Nakonetsnoi. All rights reserved.
//

@testable import WeatherAppVIP

extension WeatherReading {
	static func generic(temp: Float = 11.1,
						feelTemp: Float = 10,
						isDay: Bool = true,
						cloudCover: Int = 75,
						conditionText: String = "Cloudy with a chance of meatballs") -> WeatherReading {
		return WeatherReading(temp: temp,
							  feelTemp: feelTemp,
							  isDay: isDay,
							  cloudCover: cloudCover,
							  conditionText: conditionText)
	}
}

extension Alert.Response {
	static func generic(error: Error = "generic error") -> Alert.Response {
		return Alert.Response(error: error)
	}
}
