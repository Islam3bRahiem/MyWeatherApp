//
//  BaseView.swift
//  MyWeatherApp
//
//  Created by Islam Abd El-Rahiem on 01/10/2024.
//

import Combine
import UIKit

class BaseView<T: BaseVieWModel>: UIViewController {
    
    //MARK: - Properties
    var viewModel: T
    var coordinator: Coordinator
        
    
    //MARK: - Init
    init(viewModel: T, coordinator: Coordinator) {
        self.viewModel = viewModel
        self.coordinator = coordinator
        super.init(nibName: String(describing: type(of: self)), bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        bind(viewModel: viewModel)
        bindStates()
    }
        
    //MARK: - Functions
    func bind(viewModel: T) {
        fatalError("Please ovveride bind function")
    }
    
    private func bindStates() {
        // Handle isLoading
        viewModel.isLoading
            .receive(on: DispatchQueue.main)
            .sink { [weak self] isLoading in
                guard let self = self else { return }
                if isLoading {
                    // Show Loader
                    print("Show Loader")
                } else {
                    // Hide Loader
                    print("Hide Loader")
                }
            }
            .store(in: &viewModel.cancellables)

        // Handle displayMessage
        viewModel.displayMessage
            .receive(on: DispatchQueue.main)
            .sink { [weak self] message in
                guard let self = self else { return }
                viewModel.showAlertMsg(message)
            }
            .store(in: &viewModel.cancellables)
    }
    
}
