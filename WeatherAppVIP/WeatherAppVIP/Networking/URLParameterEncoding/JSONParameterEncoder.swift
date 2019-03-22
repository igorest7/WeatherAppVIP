//
//  JSONParameterEncoder.swift
//  WeatherAppVIP
//
//  Created by Igor Nakonetsnoi on 22/03/2019.
//  Copyright © 2019 Igor Nakonetsnoi. All rights reserved.
//

import Foundation

public struct JSONParameterEncoder: ParameterEncoder {
	public func encode(urlRequest: inout URLRequest, with parameters: Parameters) throws {
		do {
			let jsonAsData = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
			urlRequest.httpBody = jsonAsData
			if urlRequest.value(forHTTPHeaderField: "Content-Type") == nil {
				urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
			}
		}catch {
			throw CustomError.networkRequestEncodingFailed
		}
	}
}
