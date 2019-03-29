//
//  CurrentWeatherNetworkingRouterTests.swift
//  WeatherAppVIPTests
//
//  Created by Igor Nakonetsnoi on 29/03/2019.
//  Copyright © 2019 Igor Nakonetsnoi. All rights reserved.
//

import XCTest
@testable import WeatherAppVIP

class CurrentWeatherNetworkingRouterTests: XCTestCase {
	func test_asURLRequest_correctly_generates_request_with_string() throws {
		let city = "CityName"
		let router = CurrentWeatherNetworkRouter.getCurrentWeatherInCity(city)
		let request = try require(try? router.asURLRequest())
		XCTAssertEqual(request.httpMethod, HTTPMethod.get.rawValue)
		XCTAssertNotNil(request.url)
		XCTAssertTrue(request.url?.absoluteString.hasPrefix("https://api.apixu.com/v1/current.json?") ?? false)
		XCTAssertTrue(request.url?.absoluteString.contains("key=cff396985d8b44d997e181537192603") ?? false)
		XCTAssertTrue(request.url?.absoluteString.contains("q=\(city)") ?? false)
		XCTAssertEqual(request.cachePolicy, .reloadIgnoringLocalCacheData)
	}
}


