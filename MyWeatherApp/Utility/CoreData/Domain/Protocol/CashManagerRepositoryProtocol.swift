//
//  CashManagerRepositoryProtocol.swift
//  MyWeatherApp
//
//  Created by Islam Abd El-Rahiem on 03/10/2024.
//

import Foundation

enum ErrorResponse: Error{
    case DataSourceError, FetchError
}

protocol CashManagerRepositoryProtocol {
    func saveCity(name: String, days: [DailyWeatherRowViewModel]) async -> Result<Bool, ErrorResponse>
    func fetchCity(with name: String) async -> Result<[DailyWeatherRowViewModel], ErrorResponse>
}

