//
//  MainWeatherPresenter.swift
//
//  Created by Igor Nakonetsnoi on 22/03/2019.
//  Copyright © 2019 Igor Nakonetsnoi. All rights reserved.

import Foundation

final class MainWeatherPresenter {
    weak private var output: MainWeatherPresenterOutput!
    
    init(output: MainWeatherPresenterOutput) {
        self.output = output
    }
}

//MARK: - MainWeatherPresenterInput
extension MainWeatherPresenter: MainWeatherPresenterInput {

}
