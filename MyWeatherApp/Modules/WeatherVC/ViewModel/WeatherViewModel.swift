//
//  WeatherViewModel.swift
//  MyWeatherApp
//
//  Created by Islam Abd El-Rahiem on 01/10/2024.
//

import Combine
import Foundation

protocol WeatherViewModelInputs {
    func searchBarTextDidChange(with searchText: String)
    func searchBarSearchButtonClicked(with searchText: String?) 
}

protocol WeatherViewModelOutputs {
}

protocol WeatherViewModelProtocol {
    var inputs: WeatherViewModelInputs { get set }
    var outputs: WeatherViewModelOutputs { get set }
}

class WeatherViewModel: BaseVieWModel, WeatherViewModelInputs, WeatherViewModelOutputs, WeatherViewModelProtocol {
    
    //MARK: - Properties
    private let apiFetcher: WeatherApiRepositoryProtocol

    var inputs: WeatherViewModelInputs {
        get { return self }
        set {}
    }
    
    var outputs: WeatherViewModelOutputs {
        get { return self }
        set {}
    }
    
    // MARK: - Init
    init(apiFetcher: WeatherApiRepositoryProtocol = WeatherApiRepository()) {
        self.apiFetcher = apiFetcher
    }
    
    //MARK: - Outputs

    //MARK: - Inputs
    func searchBarTextDidChange(with searchText: String) {
        if searchText.isEmpty {
            print("Clear Search UI")
        }
    }
    
    func searchBarSearchButtonClicked(with searchText: String?) {
        if let searchText, !searchText.isEmpty {
            self.fetchWeather(forCity: searchText)
        }
    }
    
    // MARK: - Private Functions
    private
    func fetchWeather(forCity city: String) {
        apiFetcher.weeklyWeatherForecast(forCity: city)
        .map { response in
          response.list.map(DailyWeatherRowViewModel.init)
        }
        .map(Array.removeDuplicates)
        .receive(on: DispatchQueue.main)
        .sink(
          receiveCompletion: { [weak self] value in
            guard let self = self else { return }
            switch value {
            case .failure: break
//              self.dataSource = []
            case .finished:
              break
            }
          },
          receiveValue: { [weak self] forecast in
            guard let self = self else { return }
//            self.dataSource = forecast
        })
        .store(in: &cancellables)
    }


}
