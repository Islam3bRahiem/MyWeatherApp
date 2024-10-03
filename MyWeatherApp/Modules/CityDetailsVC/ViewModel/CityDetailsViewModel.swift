//
//  CityDetailsViewModel.swift
//  MyWeatherApp
//
//  Created by Islam Abd El-Rahiem on 03/10/2024.
//

import Combine
import Foundation

protocol CityDetailsViewModelInputs {
    func viewDidLoad()
}

protocol CityDetailsViewModelOutputs {
    var citySubject: PassthroughSubject<CurrentWeatherRowViewModel?, Never> { get }
}

// MARK: - ... Protocol
protocol CityDetailsViewModelProtocol {
    var inputs: CityDetailsViewModelInputs { get set }
    var outputs: CityDetailsViewModelOutputs { get set }
}

class CityDetailsViewModel: BaseVieWModel, CityDetailsViewModelInputs, CityDetailsViewModelOutputs, CityDetailsViewModelProtocol {
    
    //MARK: - Properties
    var inputs: CityDetailsViewModelInputs {
        get { return self }
        set {}
    }
    
    var outputs: CityDetailsViewModelOutputs {
        get { return self }
        set {}
    }
    
    private let city: String
    private let apiFetcher: WeatherApiRepositoryProtocol
    
    
    //MARK: - init
    init(_ city: String,
         apiFetcher: WeatherApiRepositoryProtocol = WeatherApiRepository()) {
        self.city = city
        self.apiFetcher = apiFetcher
    }
    
    
    //MARK: - Outputs
    var citySubject: PassthroughSubject<CurrentWeatherRowViewModel?, Never> = .init()
    
    //MARK: - Inputs
    func viewDidLoad() {
        apiFetcher.currentWeatherForecast(forCity: city)
            .map(CurrentWeatherRowViewModel.init)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] value in
                guard let self = self else { return }
                switch value {
                case .failure(let error):
                    self.citySubject.send(nil)
                    self.showAlertMsg(error.description)
                    break
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] weather in
                guard let self = self else { return }
                self.citySubject.send(weather)
            })
            .store(in: &cancellables)
    }
    
    
}
