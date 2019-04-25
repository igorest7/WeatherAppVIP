//
//  NetworkRequestManagerTests.swift
//  WeatherAppVIPTests
//
//  Created by Igor Nakonetsnoi on 06/04/2019.
//  Copyright © 2019 Igor Nakonetsnoi. All rights reserved.
//

import XCTest
import Mockingjay
@testable import WeatherAppVIP

class NetworkkRequestManagerTests: XCTestCase {
	// MARK: - System under test
	var sut: NetworkRequestManagerImplementation!
	var expectation: XCTestExpectation!

	// MARK: - Test lifecycle
	override func setUp() {
		super.setUp()
		sut = NetworkRequestManagerImplementation()
		expectation = self.expectation(description: "load")
	}

	// MARK: - Tests
	func test_valid_success_returns_valid_data() throws {
		stub(everything, jsonData(XCTestCase.jsonDataWithResponse(type: .currentWeatherValid)))
		sut.request(CurrentWeatherNetworkRouter.getCurrentWeatherInCity("city")) { result in
			switch result {
			case .left(let data):
				do {
					let weather = try JSONDecoder().decode(WeatherReading.self, from: data)
					XCTAssertEqual(weather.temp, 11.2)
					XCTAssertEqual(weather.feelTemp, 12)
					XCTAssertEqual(weather.isDay, true)
					XCTAssertEqual(weather.cloudCover, 25)
					XCTAssertEqual(weather.conditionText, "Clear")
				}catch {
					XCTFail("Valid request not parsed correctly")
				}
			case .right:
				XCTFail("Valid request returned error")
			}
			self.expectation.fulfill()
		}
		wait(for: [expectation], timeout: 3)
	}

	func test_404_error_returns_bad_request_error() {
		stub(everything, http(404))
		sut.request(CurrentWeatherNetworkRouter.getCurrentWeatherInCity("city")) { result in
			switch result {
			case .left:
				XCTFail("Error request returned success")
			case .right(let error):
				XCTAssertEqual(error.localizedDescription, "network.response.bad.request".localized)
			}
			self.expectation.fulfill()
		}
		wait(for: [expectation], timeout: 3)
	}

	func test_500_error_returns_server_error() {
		stub(everything, http(500))
		sut.request(CurrentWeatherNetworkRouter.getCurrentWeatherInCity("city")) { result in
			switch result {
			case .left:
				XCTFail("Error request returned success")
			case .right(let error):
				XCTAssertEqual(error.localizedDescription, "network.response.server.error".localized)
			}
			self.expectation.fulfill()
		}
		wait(for: [expectation], timeout: 3)
	}

	func test_600_error_returns_request_failed() {
		stub(everything, http(600))
		sut.request(CurrentWeatherNetworkRouter.getCurrentWeatherInCity("city")) { result in
			switch result {
			case .left:
				XCTFail("Error request returned success")
			case .right(let error):
				XCTAssertEqual(error.localizedDescription, "network.response.request.failed".localized)
			}
			self.expectation.fulfill()
		}
		wait(for: [expectation], timeout: 3)
	}
}
