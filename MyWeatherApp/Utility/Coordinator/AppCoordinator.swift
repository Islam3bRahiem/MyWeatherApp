//
//  AppCoordinator.swift
//  MyWeatherApp
//
//  Created by Islam Abd El-Rahiem on 01/10/2024.
//

import UIKit

class AppCoordinator: Coordinator {
    
    let window: UIWindow
            
    var navigationController: UINavigationController? {
        if let navigationController = UIApplication.topMostController() as? UINavigationController {
            return navigationController
        }
        return nil
    }
    
    init(windowScene: UIWindowScene) {
        self.window = UIWindow(windowScene: windowScene)
    }
    
    func start() {
        let viewModel = WeatherViewModel()
        let scene = WeatherVC(viewModel: viewModel, coordinator: self)
        let nav = UINavigationController(rootViewController: scene)
        window.rootViewController = nav
        window.makeKeyAndVisible()
    }

    func dismiss() {
        self.navigationController?.dismiss(animated: true)
        UIApplication.topMostController().dismiss(animated: true)
    }
    
    func pop() {
        self.navigationController?.popViewController(animated: true)
    }

    
}
