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
            let description: String
            let icon: String
        }
        struct FeelsLike: Codable {
            let day: Double
        }
        
        let temp: Temp
        let weather: [Weather]
        let pop: Float
        let uvi: Float
        let dt: Date
        let humidity: Int
        let wind_deg: Int
        let wind_speed: Float
        let sunrise: Int
        let sunset: Int
        let feels_like: FeelsLike
    }
    
    struct Hourly: Codable {
        let dt: Date
        let temp: Float
        let feels_like: Float
        let humidity: Int
        let uvi: Float
        let wind_speed: Float
        let wind_deg: Int
        struct Weather: Codable {
            let id: Int
            let main: String
            let description: String
            let icon: String
        }
        let weather: [Weather]
        let pop: Float
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
        let wind_deg: Int
        let weather: [Weather]
    }
    
    let daily: [Daily]
    let lat: Double
    let lon: Double
    let timezone_offset: Int
    let current: Current
    let hourly: [Hourly]
}
