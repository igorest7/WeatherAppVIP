//
//  MainWeatherPresenterTests.swift
//  WeatherAppVIPTests
//
//  Created by Igor Nakonetsnoi on 28/03/2019.
//  Copyright © 2019 Igor Nakonetsnoi. All rights reserved.
//

import XCTest
@testable import WeatherAppVIP

class MainWeatherPresenterTests: XCTestCase {

	// MARK: - System under test
	var sut: MainWeatherPresenter!
	var outputMock: MainWeatherPresenterOutputMock!

	// MARK: - Test lyfecycle
	override func setUp() {
		super.setUp()
		setupMainWeatherPresenter()
	}

	// MARK: - Test setup
	func setupMainWeatherPresenter() {
		outputMock = MainWeatherPresenterOutputMock()
		sut = MainWeatherPresenter(output: outputMock)
	}

	// MARK: - Mocks
	final class MainWeatherPresenterOutputMock: MainWeatherPresenterOutput {
		var presentWeatherViewModel: CurrentWeather.ViewModel?
		func presentWeather(viewModel: CurrentWeather.ViewModel) {
			presentWeatherViewModel = viewModel
		}

		var showAlertTitle: String?
		var showAlertMessage: String?
		func showAlertWith(title: String?, message: String?) {
			showAlertTitle = title
			showAlertMessage = message
		}
	}

	// MARK: Tests
	func test_receivedCurrentWeather_presents_view_model_to_output() throws {
		let weather = WeatherReading(temp: 123, feelTemp: 321, isDay: true, cloudCover: 1, conditionText: "Cloudy")
		let response = CurrentWeather.Response(weather: weather)
		sut.receivedCurrentWeather(response: response)

		let viewModel = try require(outputMock.presentWeatherViewModel)
		XCTAssertEqual(viewModel.temperature, String(format: "main.weather.temperature.label".localized, weather.temp))
		XCTAssertEqual(viewModel.feelTemperature, String(format: "main.weather.feel.temperature.label".localized, weather.feelTemp))
		XCTAssertEqual(viewModel.cloudCover, String(format: "main.weather.cloud.cover.label".localized, weather.cloudCover))
		XCTAssertEqual(viewModel.condition, "Cloudy")
	}

	func test_receivedError_shows_alert() throws {
		let response = Alert.Response.generic()
		sut.receivedError(response: response)

		XCTAssertNil(outputMock.showAlertTitle)
		let alertMessage = try require(outputMock.showAlertMessage)
		XCTAssertEqual(alertMessage, response.error.localizedDescription)
	}
}
