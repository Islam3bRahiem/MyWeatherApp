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
    case unknownError
    
    var description: String {
        switch self {
        case .parsing:
            return "Server error"
        case .network:
            return "A network error occurred."
        case .unknownError:
            return "An unknown error occurred."
        }
    }
}
