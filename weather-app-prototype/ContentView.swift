//
//  ContentView.swift
//  weather-app-prototype
//
//  Created by Varun K on 7/29/22.
//
import SwiftUI
import UIKit

struct ContentView: View {
    @AppStorage("isOnboarding") var isOnboarding: Bool = true

    var body: some View {
        
        if isOnboarding {
            OnboardingView()
        } else {
            TabView {
                HomeView2()
                    .tabItem {
                        Image(systemName: "house")
                        Text("Home")
                        
                    }
                SearchView()
                    .tabItem {
                        Image(systemName: "magnifyingglass.circle.fill")
                        Text("Search")
                    }
                SettingsView()
                    .tabItem {
                        Image(systemName: "gear")
                        Text("Settings")
                    }
            }
            .preferredColorScheme(.dark)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

