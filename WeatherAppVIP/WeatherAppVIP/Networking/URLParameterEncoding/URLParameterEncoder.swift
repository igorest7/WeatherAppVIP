//
//  URLParameterEncoder.swift
//  WeatherAppVIP
//
//  Created by Igor Nakonetsnoi on 22/03/2019.
//  Copyright © 2019 Igor Nakonetsnoi. All rights reserved.
//

import Foundation

public struct URLParameterEncoder: ParameterEncoder {
	public func encode(urlRequest: inout URLRequest, with parameters: Parameters) throws {

		guard let url = urlRequest.url else { throw CustomError.networkRequestMissingURL }

		if !parameters.isEmpty, var urlComponents = URLComponents(url: url,
													 resolvingAgainstBaseURL: false) {

			urlComponents.queryItems = [URLQueryItem]()

			for (key, value) in parameters {
				let queryItem = URLQueryItem(name: key,
											 value: "\(value)".addingPercentEncoding(withAllowedCharacters: .urlHostAllowed))
				urlComponents.queryItems?.append(queryItem)
			}
			urlRequest.url = urlComponents.url
		}

		if urlRequest.value(forHTTPHeaderField: "Content-Type") == nil {
			urlRequest.setValue("application/x-www-form-urlencoded; charset=utf-8", forHTTPHeaderField: "Content-Type")
		}
	}
}
