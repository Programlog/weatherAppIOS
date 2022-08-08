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
    
    private static var dateFormatter2: DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        return dateFormatter
    }
    
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
                myList.append("\(Int(day.temp.day))")
            }
        return myList
    }
    
    var dailyPop: String {
        return "\(Self.numberFormatter2.string(for: forecast.daily[0].pop) ?? "0%")"
    }
    
    var currentHumidity: String {
        return "\(forecast.current.humidity)%"
    }
    
    var sunrise: String {
        let date = Date(timeIntervalSince1970: TimeInterval(forecast.current.sunrise))
        return Self.dateFormatter2.string(from: date)
    }
    
    var sunset: String {
        let date = Date(timeIntervalSince1970: TimeInterval(forecast.current.sunset))
        return Self.dateFormatter2.string(from: date)
    }
    
    var currentTemp: String {
        return "\(Self.numberFormatter.string(for: convert(forecast.current.temp)) ?? "0")°"
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
    
    var currentSystemImage: String {
        return getSystemImage(icon: forecast.current.weather[0].icon)
    }
    
    var dailySystemImages: [String] {
        var myList: [String] = []
        for day in forecast.daily {
            myList.append(getSystemImage(icon: day.weather[0].icon))
        }
        return myList
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
    

    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

//struct ForecastViewModel_Previews: PreviewProvider {
//    static var previews: some View {
//        ForecastViewModel()
//    }
//}
