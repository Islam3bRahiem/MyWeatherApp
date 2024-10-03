//
//  CurrentWeatherRowViewModel.swift
//  MyWeatherApp
//
//  Created by Islam Abd El-Rahiem on 03/10/2024.
//

import Foundation

struct CurrentWeatherRowViewModel {
    
    private let item: CurrentWeatherForecastResponse
    
    init(item: CurrentWeatherForecastResponse) {
        self.item = item
    }

    var temperature: String {
        return String(format: "%.1f", item.main.temperature)
    }
    
    var maxTemperature: String {
        return String(format: "%.1f", item.main.maxTemperature)
    }
    
    var minTemperature: String {
        return String(format: "%.1f", item.main.minTemperature)
    }
    
    var humidity: String {
        return String(format: "%.1f", item.main.humidity)
    }
    
}
