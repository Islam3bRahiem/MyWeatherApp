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
    func didTapOnHeaderSection()
}

protocol WeatherViewModelOutputs {
    var reloadTableView: PassthroughSubject<Void, Never> { get }
    var navigateToDetailsScreen: PassthroughSubject<Bool, Never> { get }
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
    
    //CoreData Repository
    private var cashManagerRepository: CashManagerRepositoryProtocol
    private let coreDataSerialQueue = DispatchQueue(label: "com.coredata.dispatch.serial")

    // MARK: - Init
    init(apiFetcher: WeatherApiRepositoryProtocol = WeatherApiRepository(),
         cashManagerRepository: CashManagerRepositoryProtocol = CashManagerRepository()) {
        self.apiFetcher = apiFetcher
        self.cashManagerRepository = cashManagerRepository
    }
    
    //MARK: - Outputs
    var reloadTableView: PassthroughSubject<Void, Never> = .init()
    var navigateToDetailsScreen: PassthroughSubject<Bool, Never> = .init()
    
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
    
    func didTapOnHeaderSection() {
        self.navigateToDetailsScreen.send(!dataSource.isEmpty)
    }
    
    // MARK: - Private Functions
    private
    func fetchWeather(forCity city: String) {
        self.fetchCityFromCoreData(forCity: city)
    }
    
    private
    func fetchWeatherApi(forCity city: String) {
        print("Fetch API Success..")
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
                    self.saveToCoreData(forCity: city, data: forecast)
                })
            .store(in: &cancellables)
    }
    
    private
    func fetchCityFromCoreData(forCity city: String) {
        self.coreDataSerialQueue.async() {
            Thread.sleep(forTimeInterval: 1)
            Task.init {
                let newItem = await self.cashManagerRepository.fetchCity(with: city)
                switch newItem {
                case .success(let forecast):
                    if forecast.isEmpty {
                        self.fetchWeatherApi(forCity: city)
                    } else {
                        print("Fetch City Success..")
                        self.dataSource = forecast
                        DispatchQueue.main.async {
                            self.reloadTableView.send()
                        }
                    }
                case .failure(_):
                    self.fetchWeatherApi(forCity: city)
                    break
                }
            }
        }
    }
    
    private
    func saveToCoreData(forCity city: String, data: [DailyWeatherRowViewModel]) {
        //Cash Branches offline on coredata
        self.coreDataSerialQueue.async() {
            Thread.sleep(forTimeInterval: 1)
            Task.init {
                let newItem = await self.cashManagerRepository.saveCity(name: city, days: data)
                switch newItem {
                case .success( _):
                    print("Save City Success..")
                    break
                case .failure(let error):
                    print("Error : ", error.localizedDescription)
                    break
                }
            }
        }
    }
    
}
