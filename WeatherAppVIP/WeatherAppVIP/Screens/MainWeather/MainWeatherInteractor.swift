//
//  MainWeatherInteractor.swift
//
//  Created by Igor Nakonetsnoi on 22/03/2019.
//  Copyright © 2019 Igor Nakonetsnoi. All rights reserved.

final class MainWeatherInteractor {
    var output: MainWeatherInteractorOutput!
    
    init(output: MainWeatherInteractorOutput) {
        self.output = output
    }
}

//MARK: - MainWeatherInteractorInput
extension MainWeatherInteractor: MainWeatherInteractorInput {
}
