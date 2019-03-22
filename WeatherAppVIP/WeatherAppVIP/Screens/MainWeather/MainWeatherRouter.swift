//
//  MainWeatherRouter.swift
//
//  Created by Igor Nakonetsnoi on 22/03/2019.
//  Copyright © 2019 Igor Nakonetsnoi. All rights reserved.

import UIKit

final class MainWeatherRouterImplementation {
    
    fileprivate weak var viewController: MainWeatherViewController?
    
    init(viewController: MainWeatherViewController) {
        self.viewController = viewController
    }
}

// MARK: - MainWeatherRouter
extension MainWeatherRouterImplementation: MainWeatherRouter {
    func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    }
}
