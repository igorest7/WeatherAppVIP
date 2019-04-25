//
//  NetworkingSupportTests.swift
//  WeatherAppVIPTests
//
//  Created by Igor Nakonetsnoi on 06/04/2019.
//  Copyright © 2019 Igor Nakonetsnoi. All rights reserved.
//

import XCTest
@testable import WeatherAppVIP

class NetworkingSupportTests: XCTestCase {
	// MARK: - System under test
	var sut: NetworkServiceMock!
	var managerMock: NetworkRequestManagerMock!

	// MARK: - Test lifecycle
	override func setUp() {
		super.setUp()
		managerMock = NetworkRequestManagerMock()
		sut = NetworkServiceMock(manager: managerMock)
	}

	// MARK: - Mocks
	class NetworkRequestManagerMock: NetworkRequestManager {
		func request(_ router: URLRequestConvertible, completion: @escaping NetworkRequestManagerCompletion) {}

		var cancelCalled = false
		func cancel() {
			cancelCalled = true
		}
	}

	class NetworkServiceMock: NetworkService {
		let manager: NetworkRequestManager

		init(manager: NetworkRequestManager) {
			self.manager = manager
		}
	}

	// MARK: - Tests
	func test_network_service_cancel_request_cancels_request_in_manager() {
		sut.cancelCurrentRequest()
		XCTAssertTrue(managerMock.cancelCalled)
	}
}

