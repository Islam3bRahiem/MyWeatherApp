//
//  Coordinator.swift
//  MyWeatherApp
//
//  Created by Islam Abd El-Rahiem on 01/10/2024.
//

import UIKit

protocol Coordinator {

    var navigationController: UINavigationController? { get }
    var weather: WeatherNavigator { get }

    func start()
    func dismiss()
    func pop()
}

