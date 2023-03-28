//
//  WeatherModel.swift
//  Clima
//
//  Created by Sebastian Morado on 4/19/21.
//
//

import Foundation


struct WeatherModel {
    let conditionID: Int
    let cityName: String
    let temp: Double
    
    var tempString: String {
        return String(format: "%.1f", temp)
    }
    
    var conditionName: String {
        switch conditionID {
        case 200..<300:
            return "cloud.bolt"
        case 300..<400:
            return "cloud.drizzle"
        case 500..<600:
            return "cloud.rain"
        case 600..<700:
            return "cloud.snow"
        case 700..<800:
            return "cloud.fog"
        case 800:
            return "sun.max"
        case 800..<900:
            return "cloud"
        default:
            return "cloud"
        }
    }
    
}
