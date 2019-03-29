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
	func test_valid_weather_reading_is_decoded_from_json() throws {
		let data = try require(XCTestCase.jsonDataWithResponse(type: .currentWeatherValid))
		let weather = try JSONDecoder().decode(WeatherReading.self, from: data)
		XCTAssertEqual(weather.temp, 11.2)
		XCTAssertEqual(weather.feelTemp, 12)
		XCTAssertEqual(weather.isDay, true)
		XCTAssertEqual(weather.cloudCover, 25)
		XCTAssertEqual(weather.conditionText, "Clear")
	}

	func test_invalid_weather_reading_throws_when_decoding() throws {
		let data = try require(XCTestCase.jsonDataWithResponse(type: .currentWeatherInvalid))
		XCTAssertThrowsError(try JSONDecoder().decode(WeatherReading.self, from: data))
	}

	func test_partially_invalid_weather_reading_throws_when_decoding() throws {
		let data = try require(XCTestCase.jsonDataWithResponse(type: .currentWeatherPartiallyInvalid))
		XCTAssertThrowsError(try JSONDecoder().decode(WeatherReading.self, from: data))
	}

	func test_missing_values_weather_reading_throws_when_decoding() throws {
		let data = try require(XCTestCase.jsonDataWithResponse(type: .currentWeatherMissingValues))
		XCTAssertThrowsError(try JSONDecoder().decode(WeatherReading.self, from: data))
	}
}
