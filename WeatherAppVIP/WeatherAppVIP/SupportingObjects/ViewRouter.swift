//
//  ViewRouter.swift
//  WeatherAppVIP
//
//  Created by Igor Nakonetsnoi on 22/03/2019.
//  Copyright © 2019 Igor Nakonetsnoi. All rights reserved.
//

import UIKit

protocol ViewRouter {
	func prepare(for segue: UIStoryboardSegue, sender: Any?)
}

extension ViewRouter {
	func prepare(for segue: UIStoryboardSegue, sender: Any?) { }
}
