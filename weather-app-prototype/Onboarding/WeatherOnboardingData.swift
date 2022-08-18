//
//  WeatherOnboardingData.swift
//  weather-app
//
//  Created by Niranjan Bukkapatna on 8/1/22.
//

import SwiftUI


struct WeatherOnboarding: Identifiable {
    var id = UUID()
    var title: String
    var headline: String
    var image: Image
    var gradientColors: [Color]
}
