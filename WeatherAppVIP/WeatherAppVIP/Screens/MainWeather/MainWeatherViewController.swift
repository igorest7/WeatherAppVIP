//
//  MainWeatherViewController.swift
//
//  Created by Igor Nakonetsnoi on 22/03/2019.
//  Copyright © 2019 Igor Nakonetsnoi. All rights reserved.

import UIKit

final class MainWeatherViewController: UIViewController {
    
    // MARK: - Properties
    private let configurator = MainWeatherConfiguratorImplementation()
    var output: MainWeatherViewOutput!
    var router: MainWeatherRouter!

	// MARK: - IBOutlets
	@IBOutlet weak var temperatureLabel: UILabel!
	@IBOutlet weak var feelTemperatureLabel: UILabel!
	@IBOutlet weak var cloudCoverLabel: UILabel!
	@IBOutlet weak var conditionLabel: UILabel!
}

// MARK: - View lifecycle
extension MainWeatherViewController {
    override func awakeFromNib() {
        super.awakeFromNib()
        configurator.configureWith(viewController: self)
    }

	override func viewDidLoad() {
		super.viewDidLoad()
		output.viewDidLoad()
	}
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        router.prepare(for: segue, sender: sender)
    }
}

// MARK: - MainWeatherViewInput
extension MainWeatherViewController: MainWeatherViewInput {
	func presentWeather(viewModel: CurrentWeather.ViewModel) {
		temperatureLabel.text = viewModel.temperature
		feelTemperatureLabel.text = viewModel.feelTemperature
		cloudCoverLabel.text = viewModel.cloudCover
		conditionLabel.text = viewModel.condition
	}
}
