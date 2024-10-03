//
//  CashManagerDataSourceProtocol.swift
//  MyWeatherApp
//
//  Created by Islam Abd El-Rahiem on 03/10/2024.
//

import Foundation

protocol CashManagerDataSourceProtocol {
    func saveCity(name: String, days: [DailyWeatherRowViewModel]) async throws -> ()
    func fetchCity(with name: String) async throws -> [DailyWeatherRowViewModel]
}
