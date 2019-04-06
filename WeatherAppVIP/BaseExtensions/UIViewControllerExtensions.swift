//
//  UIViewControllerExtensions.swift
//  WeatherAppVIP
//
//  Created by Igor Nakonetsnoi on 27/03/2019.
//  Copyright © 2019 Igor Nakonetsnoi. All rights reserved.
//

import UIKit

extension UIViewController: Alertable {
	func showAlertWith(title: String?, message: String?) {
		let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
		present(alert, animated: true, completion: nil)
	}
}
