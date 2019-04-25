//
//  XCTestCaseExtensions.swift
//  WeatherAppVIPTests
//
//  Created by Igor Nakonetsnoi on 28/03/2019.
//  Copyright © 2019 Igor Nakonetsnoi. All rights reserved.
//

// This code snippet is from here https://medium.com/@johnsundell/avoiding-force-unwrapping-in-swift-unit-tests-5c2b9ea64091
import XCTest

// MARK: - Require
extension XCTestCase {
	// We conform to LocalizedError in order to be able to output
	// a nice error message.
	private struct RequireError<T>: LocalizedError {
		let file: StaticString
		let line: UInt
		// It's important to implement this property, otherwise we won't
		// get a nice error message in the logs if our tests starts to fail.
		var errorDescription: String? {
			return "😱 Required value of type \(T.self) was nil at line \(line) in file \(file)."
		}
	}
	// Using file and line lets us automatically capture where
	// the expression took place in our source code.
	func require<T>(_ expression: @autoclosure () -> T?, file: StaticString = #file, line: UInt = #line) throws -> T {
		guard let value = expression() else {
			throw RequireError<T>(file: file, line: line)
		}
		return value
	}
}

// MARK: - MockRequests
enum XCTestMockRequest: String {
	case currentWeatherValid = "CurrentWeatherValidResponse"
	case currentWeatherPartiallyInvalid = "CurrentWeatherPartiallyInvalidResponse"
	case currentWeatherInvalid = "CurrentWeatherInvalidResponse"
	case currentWeatherMissingValues = "CurrentWeatherMissinValuesResponse"
}

extension XCTestCase {
	class func jsonDataWithResponse(type: XCTestMockRequest) -> Data {
		let bundle = Bundle(for: WeatherReadingTests.classForCoder())
		guard let file = bundle.url(forResource: type.rawValue, withExtension: "json"),
		let data = try? Data(contentsOf: file) else {
			XCTFail("Json \(type.rawValue) could not be loaded")
			fatalError()
		}
		return data
	}
}
