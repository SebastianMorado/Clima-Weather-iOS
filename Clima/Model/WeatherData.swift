//
//  WeatherData.swift
//  Clima
//
//  Created by Sebastian Morado on 4/19/21.
//  Copyright © 2021 App Brewery. All rights reserved.
//

import Foundation


struct WeatherData: Decodable {
    let name: String
    let timezone: Int
    let main: Main
    let weather: [Weather]
}

struct Main: Decodable {
    let temp: Double
}

struct Weather: Decodable {
    let description: String
    let id: Int
}
