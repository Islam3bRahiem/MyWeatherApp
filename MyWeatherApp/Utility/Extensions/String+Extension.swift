//
//  String+Extension.swift
//  MyWeatherApp
//
//  Created by Islam Abd El-Rahiem on 02/10/2024.
//

import Foundation

extension Date {
    
    func dayFormatter() -> String {
        let dayFormatter: DateFormatter = {
            let formatter = DateFormatter()
            formatter.dateFormat = "dd"
            return formatter
        }()
        
        return dayFormatter.string(from: self)
    }

    func monthFormatter() -> String {
        let monthFormatter: DateFormatter = {
            let formatter = DateFormatter()
            formatter.dateFormat = "MMMM"
            return formatter
        }()
        
        return monthFormatter.string(from: self)
    }
}
