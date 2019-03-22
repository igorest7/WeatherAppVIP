//
//  CustomError.swift
//  WeatherAppVIP
//
//  Created by Igor Nakonetsnoi on 22/03/2019.
//  Copyright © 2019 Igor Nakonetsnoi. All rights reserved.
//

enum CustomError: Error {
	case networkRequestEncodingFailed
	case networkRequestMissingURL

	var localizedDescription: String {
		switch self {
		case .networkRequestEncodingFailed:
			return "error.network.encoding.failed".localized
		case .networkRequestMissingURL:
			return "error.network.missing.url".localized
		}
	}
}
