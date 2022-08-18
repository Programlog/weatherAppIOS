//
//  OnboardingView.swift
//  weather-app
//
//  Created by Niranjan Bukkapatna on 8/1/22.
//

import SwiftUI

struct OnboardingView: View {
    private let onBoardingData: [WeatherOnboarding] = OnboardingData
    var body: some View {
        TabView {
            ForEach (OnboardingData[0...4]){ item in
                CardView(onBoardingData: item)
            }
        }
        .tabViewStyle(PageTabViewStyle())
        .padding(.vertical, 20)
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
