//
//  StringsExtensions.swift
//  WeatherAppVIP
//
//  Created by Igor Nakonetsnoi on 22/03/2019.
//  Copyright © 2019 Igor Nakonetsnoi. All rights reserved.
//

import Foundation

extension String {
	var localized: String {
		return NSLocalizedString(self, tableName: nil, bundle: Bundle.main, value: "", comment: "")
	}
}

extension String: Error {}

extension String: LocalizedError {
	public var errorDescription: String? { return self }
}
