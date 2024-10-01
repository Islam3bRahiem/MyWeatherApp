//
//  BaseViewModel.swift
//  MyWeatherApp
//
//  Created by Islam Abd El-Rahiem on 01/10/2024.
//

import Combine
import UIKit

protocol ViewModel {
    var cancellables: Set<AnyCancellable> { get }
    var isLoading: PassthroughSubject<Bool, Never> { get }
    var displayMessage: PassthroughSubject<String, Never> { get }
    
    func showAlertMsg(_ message: String)
}

class BaseVieWModel: ViewModel {
    var cancellables = Set<AnyCancellable>()
    var isLoading: PassthroughSubject<Bool, Never> = .init()
    var displayMessage: PassthroughSubject<String, Never> = .init()
}

extension BaseVieWModel {
    func showAlertMsg(_ message: String) {
        let alertContoller = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        alertContoller.addAction(cancelAction)
        let top = UIApplication.topMostController()
        top.present(alertContoller, animated: true)
    }
}
