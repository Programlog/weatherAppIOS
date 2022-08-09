//
//  Forecast.swift
//  weather-app-prototype
//
//  Created by Varun K on 8/6/22.
//

import Foundation

struct Forecast: Codable {
    struct Daily: Codable {
        struct Temp: Codable {
            let min: Double
            let max: Double
            let day: Double
        }
        struct Weather: Codable {
            let id: Int
            let main: String
            let icon: String
        }
        
        let temp: Temp
        let weather: [Weather]
        let pop: Double
        let dt: Date
        let humidity: Int
    }
    
    struct Current: Codable {
        struct Weather: Codable {
            let id: Int
            let main: String
            let icon: String
            let description: String
        }
        let sunrise: Int
        let sunset: Int
        let temp: Double
        let feels_like: Double
        let humidity: Int
        let uvi: Double
        let wind_speed: Double
        let wind_deg: Double
        let weather: [Weather]
    }
    
    let daily: [Daily]
    let lat: Double
    let lon: Double
    let timezone_offset: Int
    let current: Current
}
