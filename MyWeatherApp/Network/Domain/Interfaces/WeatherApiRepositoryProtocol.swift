//
//  WeatherApiRepositoryProtocol.swift
//  MyWeatherApp
//
//  Created by Islam Abd El-Rahiem on 02/10/2024.
//

import Combine

protocol WeatherApiRepositoryProtocol {
    func weeklyWeatherForecast(forCity city: String) -> AnyPublisher<WeeklyForecastResponse, ResponseError>
    func currentWeatherForecast(forCity city: String) -> AnyPublisher<CurrentWeatherForecastResponse, ResponseError>
}
