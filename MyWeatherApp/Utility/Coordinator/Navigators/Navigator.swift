//
//  Navigator.swift
//  MyWeatherApp
//
//  Created by Islam Abd El-Rahiem on 01/10/2024.
//

import UIKit

enum NavigatorTypes {
    case push
    case present
}

protocol Navigator {
    associatedtype Destination
    init(coordinator: Coordinator)
    var coordinator: Coordinator { get }
    func navigate(to destination: Destination, with navigationType: NavigatorTypes)
    func viewController(for destination: Destination, coordinator: Coordinator) -> UIViewController
}

extension Navigator {
    func navigate(to destination: Destination,
                  with navigationType: NavigatorTypes = .push) {
        let viewController = self.viewController(for: destination, coordinator: coordinator)
        switch navigationType {
        case .push:
            coordinator.navigationController?.pushViewController(viewController, animated: true)
        case .present:
            UIApplication.topMostController().present(viewController, animated: true, completion: nil)
        }
    }
}
