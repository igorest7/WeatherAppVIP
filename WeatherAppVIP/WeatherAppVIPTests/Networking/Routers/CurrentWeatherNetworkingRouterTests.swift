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
		XCTAssertEqual(request.url, URL(string: "https://api.apixu.com/v1/current.json?key=cff396985d8b44d997e181537192603&q=\(city)"))
		XCTAssertEqual(request.cachePolicy, .reloadIgnoringLocalCacheData)
	}
}


