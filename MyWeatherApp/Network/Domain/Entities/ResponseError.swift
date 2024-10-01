//
//  ResponseError.swift
//  MyWeatherApp
//
//  Created by Islam Abd El-Rahiem on 02/10/2024.
//

import Foundation

enum ResponseError: Error {
    case parsing(description: String)
    case network(description: String)
}
