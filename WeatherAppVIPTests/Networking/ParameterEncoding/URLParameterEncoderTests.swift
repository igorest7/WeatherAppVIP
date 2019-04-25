//
//  URLParameterEncoderTests.swift
//  WeatherAppVIPTests
//
//  Created by Igor Nakonetsnoi on 06/04/2019.
//  Copyright © 2019 Igor Nakonetsnoi. All rights reserved.
//

import XCTest
@testable import WeatherAppVIP

class URLParameterEncoderTests: XCTestCase {
	// MARK: - System under test
	var sut: URLParameterEncoder!

	// MARK: - Test lifecycle
	override func setUp() {
		super.setUp()
		sut = URLParameterEncoder()
	}
	
	// MARK: - Tests
	func test_encoding_with_parameters_url_encodes_them_in_url() throws {
		let url = URL(string: "https://google.com")!
		let cachePolicy = URLRequest.CachePolicy.reloadIgnoringLocalCacheData
		var urlRequest = URLRequest(url: url, cachePolicy: cachePolicy)
		let parameter = "parameter"
		let key = "key"

		try sut.encode(urlRequest: &urlRequest, with: [key: parameter])
		let urlResult = try require(urlRequest.url)
		XCTAssertEqual(urlResult.absoluteString, url.absoluteString + "?\(key)=\(parameter)" )
		XCTAssertNil(urlRequest.httpBody)
	}

	func test_encoding_with_no_parameters_returns_starting_url() throws {
		let url = URL(string: "https://google.com")!
		let cachePolicy = URLRequest.CachePolicy.reloadIgnoringLocalCacheData
		var urlRequest = URLRequest(url: url, cachePolicy: cachePolicy)

		try sut.encode(urlRequest: &urlRequest, with: [:])
		let urlResult = try require(urlRequest.url)
		XCTAssertEqual(urlResult.absoluteString, url.absoluteString)
		XCTAssertNil(urlRequest.httpBody)
	}

	func test_encoding_sets_correct_default_content_type_header() throws {
		let url = URL(string: "https://google.com")!
		let cachePolicy = URLRequest.CachePolicy.reloadIgnoringLocalCacheData
		var urlRequest = URLRequest(url: url, cachePolicy: cachePolicy)

		try sut.encode(urlRequest: &urlRequest, with: [:])//
		let headerFields = try require(urlRequest.allHTTPHeaderFields)
		let header = headerFields["Content-Type"]
		XCTAssertEqual(header, "application/x-www-form-urlencoded; charset=utf-8")
	}

	func test_encoding_with_no_url_throws_error() {
		let url = URL(string: "https://google.com")!
		let cachePolicy = URLRequest.CachePolicy.reloadIgnoringLocalCacheData
		var urlRequest = URLRequest(url: url, cachePolicy: cachePolicy)
		urlRequest.url = nil

		XCTAssertThrowsError(try sut.encode(urlRequest: &urlRequest, with: [:])) { (error) in
			XCTAssertEqual(error.localizedDescription, "error.network.missing.url".localized)
		}
	}
}
