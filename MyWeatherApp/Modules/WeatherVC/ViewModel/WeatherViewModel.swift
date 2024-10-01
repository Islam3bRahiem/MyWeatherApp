//
//  WeatherViewModel.swift
//  MyWeatherApp
//
//  Created by Islam Abd El-Rahiem on 01/10/2024.
//

import Foundation

protocol WeatherViewModelInputs {
}

protocol WeatherViewModelOutputs {
}

protocol WeatherViewModelProtocol {
    var input: WeatherViewModelInputs { get set }
    var output: WeatherViewModelOutputs { get set }
}

class WeatherViewModel: BaseVieWModel, WeatherViewModelInputs, WeatherViewModelOutputs, WeatherViewModelProtocol {
    
    //MARK: - Properties
    var input: WeatherViewModelInputs {
        get { return self }
        set {}
    }
    
    var output: WeatherViewModelOutputs {
        get { return self }
        set {}
    }
    
    //MARK: - Outputs

    //MARK: - Inputs

}
