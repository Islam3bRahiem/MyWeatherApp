//
//  WeatherNavigator.swift
//  MyWeatherApp
//
//  Created by Islam Abd El-Rahiem on 02/10/2024.
//

import UIKit

class WeatherNavigator: Navigator {
    var coordinator: Coordinator
    
    enum Destination {
        case cityDetails(String)
    }
    
    required init(coordinator: Coordinator) {
        self.coordinator = coordinator
    }

    func viewController(for destination: Destination, coordinator: Coordinator) -> UIViewController {
        switch destination {
        case .cityDetails(let city):
            let viewModel = CityDetailsViewModel(city)
            let scene = CityDetailsVC(viewModel: viewModel, coordinator: coordinator)
            return scene
        }
    }
}
