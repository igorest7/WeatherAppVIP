//
//  MainWeatherConfigurator.swift
//
//  Created by Igor Nakonetsnoi on 22/03/2019.
//  Copyright © 2019 Igor Nakonetsnoi. All rights reserved.

import Foundation

final class MainWeatherConfiguratorImplementation: MainWeatherConfigurator {
    
    func configureWith(viewController: MainWeatherViewController) {
        let router = MainWeatherRouterImplementation(viewController: viewController)
        
        let presenter = MainWeatherPresenter(output: viewController)
        
        let interactor = MainWeatherInteractor(output: presenter)
        
        viewController.output = interactor
        viewController.router = router
    }
}
