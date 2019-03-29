//
//  WeatherReadingTests.swift
//  WeatherAppVIPTests
//
//  Created by Igor Nakonetsnoi on 29/03/2019.
//  Copyright © 2019 Igor Nakonetsnoi. All rights reserved.
//

import XCTest
@testable import WeatherAppVIP

class WeatherReadingTests: XCTestCase {
	func test_weather_reading_correctly_initialises_from_json() throws {
		let data = try require(XCTestCase.jsonDataWithResponse(type: .currentWeatherValid))
		let weather = try JSONDecoder().decode(WeatherReading.self, from: data)
		XCTAssertEqual(weather.temp, 11.2)
		XCTAssertEqual(weather.feelTemp, 12)
		XCTAssertEqual(weather.isDay, true)
		XCTAssertEqual(weather.cloudCover, 25)
		XCTAssertEqual(weather.conditionText, "Clear")
	}
}
