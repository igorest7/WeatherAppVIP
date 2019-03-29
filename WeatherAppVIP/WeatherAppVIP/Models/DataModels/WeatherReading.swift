//
//  WeatherReading.swift
//  WeatherAppVIP
//
//  Created by Igor Nakonetsnoi on 27/03/2019.
//  Copyright © 2019 Igor Nakonetsnoi. All rights reserved.
//

struct WeatherReading: Decodable, Equatable {
	let temp: Float
	let feelTemp: Float
	let isDay: Bool
	let cloudCover: Int
	let conditionText: String

	enum RootKeys: String, CodingKey {
		case current
	}

	enum MainKeys: String, CodingKey {
		case temp = "temp_c"
		case feelTemp = "feelslike_c"
		case isDay = "is_day"
		case cloudCover = "cloud"
		case condition = "condition"
	}

	enum Conditionkeys: String, CodingKey {
		case conditionText = "text"
	}

	init(temp: Float,
		 feelTemp: Float,
		 isDay: Bool,
		 cloudCover: Int,
		 conditionText: String) {
		self.temp = temp
		self.feelTemp = feelTemp
		self.isDay = isDay
		self.cloudCover = cloudCover
		self.conditionText = conditionText
	}

	init(from decoder: Decoder) throws {
		let rootContainer = try decoder.container(keyedBy: RootKeys.self)
		let mainContainer = try rootContainer.nestedContainer(keyedBy: MainKeys.self, forKey: .current)
		temp = try mainContainer.decode(Float.self, forKey: .temp)
		feelTemp = try mainContainer.decode(Float.self, forKey: .feelTemp)
		isDay = try mainContainer.decode(Int.self, forKey: .isDay) == 1 ? true : false
		cloudCover = try mainContainer.decode(Int.self, forKey: .cloudCover)

		let conditionContainer = try mainContainer.nestedContainer(keyedBy: Conditionkeys.self, forKey: .condition)
		conditionText = try conditionContainer.decode(String.self, forKey: .conditionText)
	}
}
