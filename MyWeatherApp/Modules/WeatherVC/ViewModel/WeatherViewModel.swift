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
    var reloadTableView: PassthroughSubject<Void, Never> { get }
    var numberOfItems: Int { get }
    func cellViewModel(at index: Int) -> DailyWeatherRowViewModel
}

protocol WeatherViewModelProtocol {
    var inputs: WeatherViewModelInputs { get set }
    var outputs: WeatherViewModelOutputs { get set }
}

class WeatherViewModel: BaseVieWModel, WeatherViewModelInputs, WeatherViewModelOutputs, WeatherViewModelProtocol {
    
    //MARK: - Properties
    var inputs: WeatherViewModelInputs {
        get { return self }
        set {}
    }
    
    var outputs: WeatherViewModelOutputs {
        get { return self }
        set {}
    }
    
    private let apiFetcher: WeatherApiRepositoryProtocol
    private var dataSource: [DailyWeatherRowViewModel] = []
    
    // MARK: - Init
    init(apiFetcher: WeatherApiRepositoryProtocol = WeatherApiRepository()) {
        self.apiFetcher = apiFetcher
    }
    
    //MARK: - Outputs
    var reloadTableView: PassthroughSubject<Void, Never> = .init()
    
    var numberOfItems: Int {
        return dataSource.count
    }

    func cellViewModel(at index: Int) -> DailyWeatherRowViewModel {
        return dataSource[index]
    }
    
    //MARK: - Inputs
    func searchBarTextDidChange(with searchText: String) {
        if searchText.isEmpty {
            self.dataSource.removeAll()
            self.reloadTableView.send()
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
                    guard let self else { return }
                    switch value {
                    case .failure:
                        self.dataSource = []
                        self.reloadTableView.send()
                    case .finished:
                        break
                    }
                },
                receiveValue: { [weak self] forecast in
                    guard let self else { return }
                    self.dataSource = forecast
                    self.reloadTableView.send()
                })
            .store(in: &cancellables)
    }
    
    
}
