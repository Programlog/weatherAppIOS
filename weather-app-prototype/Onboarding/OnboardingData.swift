//
//  OnboardingData.swift
//  weather-app
//
//  Created by Niranjan Bukkapatna on 8/1/22.
//

import SwiftUI

let OnboardingData: [WeatherOnboarding] = [
    WeatherOnboarding(title: "Weather +", headline: "Weather reimagned", image: Image(systemName: "cloud.sun.fill"), gradientColors: [Color("ColorBlueberryLight"), Color(.gray)]),
    
    WeatherOnboarding(title: "No Ads. No Trackers", headline: "We don't track any of your data. Your weather, your data. ", image: Image(systemName: "eye.slash.circle"), gradientColors: [Color("ColorBlueberryLight"),Color("ColorBlueberryDark")]),
    
    WeatherOnboarding(title: "Simplicity", headline: "The most important information upfront", image: Image(systemName: "rectangle.and.hand.point.up.left"), gradientColors: [Color("ColorGrapefruitLight"), Color("ColorGrapefruitDark")]),
    
    WeatherOnboarding(title: "Up To Date", headline: "Always giving the most accurate, real time weather data", image: Image(systemName: "arrow.triangle.2.circlepath.circle"), gradientColors: [Color("YellowLight"), Color("YellowDark")]),

    WeatherOnboarding(title: "Anywhere", headline: "Get comprehensive weather data where ever you may be", image: Image(systemName: "globe.americas.fill"), gradientColors: [Color("ColorGooseberryLight"), Color("ColorGooseberryDark")])

    
]
