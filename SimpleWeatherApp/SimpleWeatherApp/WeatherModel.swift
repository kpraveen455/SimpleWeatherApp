//
//  WeatherModel.swift
//  SimpleWeatherApp
//
//  Created by praveen on 15/12/24.
//

import Foundation


import Foundation

struct WeatherResponse: Codable {
    let main: Main
    let name: String
}

struct Main: Codable {
    let temp: Double
}
