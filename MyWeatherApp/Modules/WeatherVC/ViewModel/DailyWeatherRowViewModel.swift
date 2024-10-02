//
//  DailyWeatherRowViewModel.swift
//  MyWeatherApp
//
//  Created by Islam Abd El-Rahiem on 02/10/2024.
//

import Foundation

struct DailyWeatherRowViewModel: Identifiable {
    
    private let item: WeeklyForecastResponse.Item
    
    var id: String {
        return day + temperature + title
    }
    
    var day: String {
        return item.date.dayFormatter()
    }
    
    var month: String {
        return item.date.monthFormatter()
    }
    
    var temperature: String {
        return String(format: "%.1f", item.main.temp)
    }
    
    var title: String {
        guard let title = item.weather.first?.main.rawValue else { return "" }
        return title
    }
    
    var fullDescription: String {
        guard let description = item.weather.first?.weatherDescription else { return "" }
        return description
    }
    
    init(item: WeeklyForecastResponse.Item) {
        self.item = item
    }
}

extension DailyWeatherRowViewModel: Hashable {
    
    static func == (lhs: DailyWeatherRowViewModel, rhs: DailyWeatherRowViewModel) -> Bool {
        return lhs.day == rhs.day
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.day)
    }
}
