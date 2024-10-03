//
//  DailyWeatherRowViewModel.swift
//  MyWeatherApp
//
//  Created by Islam Abd El-Rahiem on 02/10/2024.
//

import CoreData

struct DailyWeatherRowViewModel: Identifiable {
    
    private var _day: String
    private var _month: String
    private var _temperature: String
    private var _title: String
    private var _fullDescription: String
    
    init(item: WeeklyForecastResponse.Item) {
        self._day = item.date.dayFormatter()
        self._month = item.date.monthFormatter()
        self._temperature = String(format: "%.1f", item.main.temp)
        self._title = item.weather.first?.main.rawValue ?? ""
        self._fullDescription = item.weather.first?.weatherDescription ?? ""
    }
    
    init(city: CityEntity) {
        self._day = city.day ?? ""
        self._month = city.month ?? ""
        self._temperature = city.temperature ?? ""
        self._title = city.title ?? ""
        self._fullDescription = city.fullDescription ?? ""
    }
        
    var id: String {
        return day + temperature + title
    }
    
    var day: String {
        return self._day
    }
    
    var month: String {
        return self._month
    }
    
    var temperature: String {
        return self._temperature
    }
    
    var title: String {
        return self._title
    }
    
    var fullDescription: String {
        return self._fullDescription
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
