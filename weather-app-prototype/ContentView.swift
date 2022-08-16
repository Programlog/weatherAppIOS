//
//  ContentView.swift
//  weather-app-prototype
//
//  Created by Varun K on 7/29/22.
//
import SwiftUI
import UIKit

struct ContentView: View {
    init() {
        UITabBar.appearance().barTintColor = UIColor.black
    }
    var body: some View {
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
                .preferredColorScheme(.dark)
        }
        .font(.headline)
            
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

