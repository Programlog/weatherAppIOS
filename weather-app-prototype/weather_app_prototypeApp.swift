//
//  weather_app_prototypeApp.swift
//  weather-app-prototype
//
//  Created by Varun K on 7/29/22.
//

import SwiftUI

@main
struct weather_app_prototypeApp: App {
    @StateObject var forecastObject = ForecastListViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(forecastObject)
        }
    }
}
