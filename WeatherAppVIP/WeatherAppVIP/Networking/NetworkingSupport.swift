//
//  RemoteServicesSupport.swift
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

enum Result<String> {
	case success
	case failure(String)
}

protocol RemoteService {
	func handleNetworkResponse(_ response: HTTPURLResponse) -> Result<String>
}

extension RemoteService {
	func handleNetworkResponse(_ response: HTTPURLResponse) -> Result<String> {
		switch response.statusCode {
		case 200...299: return .success
		case 401...500: return .failure(NetworkResponse.authenticationError.rawValue)
		case 501...599: return .failure(NetworkResponse.badRequest.rawValue)
		case 600: return .failure(NetworkResponse.outdated.rawValue)
		default: return .failure(NetworkResponse.failed.rawValue)
		}
	}
}

// MARK: - Response handling
enum NetworkResponse: String {
	case success
	case authenticationError
	case badRequest
	case outdated
	case failed
	case noData
	case unableToDecode
	case unknownError

	typealias RawValue = String

	init?(rawValue: String) {
		switch rawValue {
		case "network.response.success".localized: self = .success
		case "network.response.authentication.failed".localized: self = .authenticationError
		case "network.response.bad.request".localized: self = .badRequest
		case "network.response.outdated.request".localized: self = .outdated
		case "network.response.request.failed".localized: self = .failed
		case "network.response.empty.response".localized: self = .noData
		case "network.response.invalid.response".localized: self = .unableToDecode
		case "network.response.unknown".localized: self = .unknownError
		default: return nil
		}
	}

	var rawValue: String {
		switch self {
		case .success: return "network.response.success".localized
		case .authenticationError: return "network.response.authentication.failed".localized
		case .badRequest: return "network.response.bad.request".localized
		case .outdated: return "network.response.outdated.request".localized
		case .failed: return "network.response.request.failed".localized
		case .noData: return "network.response.empty.response".localized
		case .unableToDecode: return "network.response.invalid.response".localized
		case .unknownError: return "network.response.unknown".localized
		}
	}
}
