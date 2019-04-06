//
//  MainWeatherConfiguratorTests.swift
//  WeatherAppVIPTests
//
//  Created by Igor Nakonetsnoi on 28/03/2019.
//  Copyright © 2019 Igor Nakonetsnoi. All rights reserved.
//

import XCTest
@testable import WeatherAppVIP

class CardListConfiguratorTests: XCTestCase {
	func test_main_weather_configurator_configures_view_controller_with_router_and_output() {
		let viewController = MainWeatherViewController()
		let configurator = MainWeatherConfiguratorImplementation()
		configurator.configureWith(viewController: viewController)
		XCTAssertNotNil(viewController.router)
		XCTAssertNotNil(viewController.output)
	}
}
