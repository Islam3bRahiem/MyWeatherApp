//
//  CashManagerRepository.swift
//  MyWeatherApp
//
//  Created by Islam Abd El-Rahiem on 03/10/2024.
//

import Foundation

struct CashManagerRepository: CashManagerRepositoryProtocol {
    
    var dataSource: CashManagerDataSourceProtocol

    init() {
        self.dataSource = CashManagerDataSource()
    }

    
    func saveCity(name: String, days: [DailyWeatherRowViewModel]) async -> Result<Bool, ErrorResponse> {
        do{
            try await dataSource.saveCity(name: name, days: days)
            return .success(true)
        }catch{
            return .failure(.DataSourceError)
        }
    }
    
    func fetchCity(with name: String) async -> Result<[DailyWeatherRowViewModel], ErrorResponse> {
        do {
            let _todos =  try await dataSource.fetchCity(with: name)
            return .success(_todos)
        } catch{
            return .failure(.FetchError)
        }
    }

}
