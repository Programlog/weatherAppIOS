//
//  ForecastViewModel.swift
//  weather-app-prototype
//
//  Created by Varun K on 8/6/22.
//
import CoreLocation

import SwiftUI

struct ForecastViewModel: View {
    let forecast: Forecast
    var system: Int

    
    private static var dateFormatter: DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "E, MMM, d"
        return dateFormatter
    }
    
//    private static var dateFormatter2: DateFormatter {
//        let dateFormatter = NSDate()
//        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
//        return dateFormatter
//    }
    
    private static var numberFormatter: NumberFormatter {
        let numberFormatter = NumberFormatter()
        numberFormatter.maximumFractionDigits = 0
        return numberFormatter
    }
    
    private static var numberFormatter2: NumberFormatter {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .percent
        return numberFormatter
    }
    
    func convert(_ temp: Double) -> Double {
        if system == 1 {
            return temp
        } else {
            return (temp - 32) * 5/9
        }
    }
    
    func  getSystemImage(icon: String) -> String {
        switch icon {
        case "01d": return "sun.max.fill"
        case "02d": return "cloud.sun.fill"
        case "03d": return "cloud.fill"
        case "04d": return "cloud.fill"
        case "09d": return "cloud.rain.fill"
        case "10d": return "cloud.sun.rain.fill"
        case "11d": return "cloud.bolt.rain.fill"
        case "13d": return "cloud.snow.fill"
        case "50d": return "cloud.fog.fill"
        
        case "01n": return "moon.fill"
        case "02n": return "cloud.moon.fill"
        case "03n": return "cloud.fill"
        case "04n": return "cloud.fill"
        case "09n": return "cloud.rain.fill"
        case "10n": return "cloud.moon.rain.fill"
        case "11n": return "cloud.bolt.rain.fill"
        case "13n": return "cloud.snow.fill"
        case "50n": return "cloud.fog.fill"
        default: return "cloud.sun.fill"
        }
        
    }

    
    var date: String {
        return Self.dateFormatter.string(from: forecast.daily[0].dt)
    }
    
    var dailyMain: String {
        forecast.daily[0].weather[0].main.capitalized
    }
    
    var dailyHigh: String {
        return "\(Self.numberFormatter.string(for: convert(forecast.daily[0].temp.max)) ?? "0")°"
    }
    
    var dailyLow: String {
        return "\(Self.numberFormatter.string(for: convert(forecast.daily[0].temp.min)) ?? "0")°"
    }
    
    var dailyTemp: [String] {
        var myList: [String] = []
            for day in forecast.daily {
                myList.append("\(Int(convert(day.temp.day)))")
            }
        return myList
    }
    
    var dailyPop: String {
        return "\(Self.numberFormatter2.string(for: forecast.daily[0].pop) ?? "0%")"
    }
    
    var currentHumidity: String {
        return "\(forecast.current.humidity)%"
    }
    
    var dailySystemImages: [String] {
        var myList: [String] = []
        for day in forecast.daily {
            myList.append(getSystemImage(icon: day.weather[0].icon))
        }
        return myList
    }
    
    var Daily: [String] {
        return [dailyMain, dailyHigh, dailyLow, dailyPop]
    }
    
    
    var currentSunrise: String {
        let date = NSDate(timeIntervalSince1970: TimeInterval(forecast.current.sunrise+forecast.timezone_offset))
        let dayTimePeriodFormatter = DateFormatter()
        dayTimePeriodFormatter.dateFormat = "h:mm a"
        dayTimePeriodFormatter.timeZone = TimeZone(abbreviation: "UTC")
        let dateString = dayTimePeriodFormatter.string(from: date as Date)
        
        return dateString
    }
    
    var currentSunset: String {
        let date = NSDate(timeIntervalSince1970: TimeInterval(forecast.current.sunset+forecast.timezone_offset))
        let dayTimePeriodFormatter = DateFormatter()
        dayTimePeriodFormatter.dateFormat = "h:mm a"
        dayTimePeriodFormatter.timeZone = TimeZone(abbreviation: "UTC")
        let dateString = dayTimePeriodFormatter.string(from: date as Date)
        
        return dateString
    }
    
    var currentTemp: String {
        return "\(Self.numberFormatter.string(for: convert(forecast.current.temp)) ?? "0")°"
    }
    
    var currentFeelsLikeTemp: String {
        return "\(Self.numberFormatter.string(for: convert(forecast.current.feels_like)) ?? "0")°"
    }
        
    var currentSystemImage: String {
        return getSystemImage(icon: forecast.current.weather[0].icon)
    }
    
    var cityName: String {
        var cityString: String = "Princeton"
        let geoCoder = CLGeocoder()
        let location = CLLocation(latitude: forecast.lat, longitude: forecast.lon)
        geoCoder.reverseGeocodeLocation(location, completionHandler: { placemarks, error -> Void in
            guard let placeMark = placemarks?.first else { return }
                if let city = placeMark.subAdministrativeArea {
                    cityString = city
                }
            })

        return cityString

    }
    
    var currentWindSpeed: String {
        return "\(Int(forecast.current.wind_speed))"
    }
    
    var currentWinDir: String {
        let de = Int(forecast.current.wind_deg)
        if 45 > de && de>=0 {return "NE"}
        else if 90 > de && de >= 45 {return "E"}
        else if 135 > de && de >= 90 {return "SE"}
        else if 180 > de && de >= 135 {return "S"}
        else if 225 > de && de >= 180 {return "SW"}
        else if 270 > de && de >= 225 {return "W"}
        else if 315 > de && de >= 270 {return "NW"}
        else {
            return "N"
        }
    }
    
    var currentUv: String {
        return "\(Int(forecast.current.uvi))"
    }
    
    var Current: [String] {
        return [currentTemp, currentFeelsLikeTemp, currentHumidity, currentWindSpeed + " " + currentWinDir, currentSunrise, currentSunset, currentUv, currentSystemImage]
    }

    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}
