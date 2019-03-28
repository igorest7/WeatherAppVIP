//
//  MainWeatherInteractorTests.swift
//  WeatherAppVIPTests
//
//  Created by Igor Nakonetsnoi on 28/03/2019.
//  Copyright © 2019 Igor Nakonetsnoi. All rights reserved.
//

import XCTest
@testable import WeatherAppVIP

class MainWeatherInteractorTests: XCTestCase {

	// MARK: - System under test
	var sut: MainWeatherInteractor!
	var outputMock: MainWeatherInteractorOutputMock!
	var workerMock: WeatherNetworkWorkerMock!

	// MARK: - Test lifecycle
	override func setUp() {
		super.setUp()
		setupMainWeatherInteractor()
	}

	// MARK: - Test setup
	func setupMainWeatherInteractor() {
		outputMock = MainWeatherInteractorOutputMock()
		sut = MainWeatherInteractor(output: outputMock)
		workerMock = WeatherNetworkWorkerMock()
		sut.worker = workerMock
	}

	// MARK: - Mocks
	final class MainWeatherInteractorOutputMock: MainWeatherInteractorOutput {
		var receivedCurrentWeatherResponse: CurrentWeather.Response?
		func receivedCurrentWeather(response: CurrentWeather.Response) {
			receivedCurrentWeatherResponse = response
		}

		var receivedErrorResponse: Alert.Response?
		func receivedError(response: Alert.Response) {
			receivedErrorResponse = response
		}
	}

	// MARK: - Tests
	func test_viewDidLoad_calls_getCurrentWeatherInCity() {
		sut.viewDidLoad()
		XCTAssertTrue(workerMock.getCurrentWeatherInCityCalled)
	}

	func test_viewDidLoad_sends_success_response_to_output() throws {
		let weather = WeatherReading.generic()
		workerMock.getCurrentWeatherInCityResult = .left(weather)
		sut.viewDidLoad()

		let response = try require(outputMock.receivedCurrentWeatherResponse)
		XCTAssertEqual(response.weather, weather)
	}

	func test_viewDidLoad_sends_error_response_to_output() throws {
		let error = "testError"
		workerMock.getCurrentWeatherInCityResult = .right(error)
		sut.viewDidLoad()

		let response = try require(outputMock.receivedErrorResponse)
		XCTAssertEqual(response.error.localizedDescription, error)
	}

	func test_viewDidLoad_sends_London_weather_request() throws {
		sut.viewDidLoad()

		let request = try require(workerMock.getCurrentWeatherInCityRequest)
		XCTAssertEqual(request, "London")
	}
}
