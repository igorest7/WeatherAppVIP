//
//  Error.swift
//  WeatherAppVIP
//
//  Created by Igor Nakonetsnoi on 27/03/2019.
//  Copyright © 2019 Igor Nakonetsnoi. All rights reserved.
//

enum Alert {
	struct Response {
		let error: Error
	}

	struct ViewModel {
		let title: String?
		let message: String?
	}
}
