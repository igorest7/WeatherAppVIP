//
//  CurrentWeatherNetworkRouter.swift
//  WeatherAppVIP
//
//  Created by Igor Nakonetsnoi on 22/03/2019.
//  Copyright © 2019 Igor Nakonetsnoi. All rights reserved.
//

import Foundation

enum CurrentWeatherNetworkRouter: URLRequestConvertible {

	case getCurrentWeatherInCity(String)

	func asURLRequest() throws -> URLRequest {
		var method: HTTPMethod {
			switch self {
			case .getCurrentWeatherInCity:
				return .get
			}
		}

		let parameters: ([String: Any]) = {
			switch self {
			case .getCurrentWeatherInCity(let city):
				return (["key": Constants.apiKey, "q": city])
			}
		}()

		let url: URL = {
			let relativePath: String
			switch self {
			case .getCurrentWeatherInCity:
				relativePath = "current.json"
			}
			return URL(string: Constants.baseURLString)!.appendingPathComponent(relativePath)
		}()

		let cachePolicy: URLRequest.CachePolicy = {
			switch self {
			default:
				return URLRequest.CachePolicy.reloadIgnoringLocalCacheData
			}
		}()

		var urlRequest = URLRequest(url: url, cachePolicy: cachePolicy)
		urlRequest.httpMethod = method.rawValue

		let encoding: ParameterEncoder = {
			switch method {
			case .get:
				return URLParameterEncoder()
			default:
				return JSONParameterEncoder()
			}
		}()

		do {
			try encoding.encode(urlRequest: &urlRequest, with: parameters)
		} catch  {
			throw error
		}

		return urlRequest
	}
}

