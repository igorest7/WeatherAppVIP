//
//  NetworkServicesSupport.swift
//  WeatherAppVIP
//
//  Created by Igor Nakonetsnoi on 22/03/2019.
//  Copyright © 2019 Igor Nakonetsnoi. All rights reserved.
//

import Foundation

protocol URLRequestConvertible {
	func asURLRequest() throws -> URLRequest
}

public enum HTTPMethod : String {
	case get     = "GET"
	case post    = "POST"
	case put     = "PUT"
	case patch   = "PATCH"
	case delete  = "DELETE"
}

public typealias HTTPHeaders = [String:String]

public enum HTTPTask {
	case request

	case requestParameters(bodyParameters: Parameters?,
		bodyEncoding: ParameterEncoding,
		urlParameters: Parameters?)

	case requestParametersAndHeaders(bodyParameters: Parameters?,
		bodyEncoding: ParameterEncoding,
		urlParameters: Parameters?,
		additionHeaders: HTTPHeaders?)
}

enum NetworkRequestResult {
	case success
	case failure(Error)
}

// MARK: - NetworkService
protocol NetworkService {
	var manager: NetworkRequestManager { get }
	func cancelCurrentRequest()
}

extension NetworkService {
	func cancelCurrentRequest() {
		manager.cancel()
	}
}
