//
//  SearchView.swift
//  weather-app
//
//  Created by Niranjan Bukkapatna on 7/31/22.
//

import SwiftUI

struct SearchView: View {
//    @ObservedObject var forecastListVM = ForecastListViewModel()
    @EnvironmentObject var forecastListVM: ForecastListViewModel
    @State var isSheet: Bool = false
    private let cities = loadCSV(from: "us_cities")
    private var filtered: [City] {
        if forecastListVM.location == "" {return cities}
        return cities.filter {
            $0.CITY.lowercased().localizedCaseInsensitiveContains(forecastListVM.location)
        }
    }

    var body: some View {
        NavigationView {
            List(filtered) { city in
                NavigationLink(isActive: Binding<Bool>(get: {isSheet}, set: {isSheet = $0; forecastListVM.fetchData(lat: Double(city.LATITUDE)!, lon: Double(city.LONGITUDE)!)})) {
                    HomeView2()
                } label: {
                    Text("\(city.CITY), \(city.STATE_CODE)")
                }
//                NavigationLink(destination: <#T##() -> _#>, label: Text("\(city.CITY), \(city.STATE_CODE)"))
            }

        }.searchable(text: $forecastListVM.location, placement: .navigationBarDrawer(displayMode: .always), prompt: "Enter a city") {
            if filtered.isEmpty {
                let randomCity = cities.randomElement()
                Text("Maybe you are looking for \(randomCity?.CITY ?? "Princeton"), \(randomCity?.STATE_CODE ?? "NJ")")
                    .searchCompletion("\(randomCity?.CITY ?? "Princeton"), \(randomCity?.STATE_CODE ?? "NJ")")
            }
        }
        .navigationTitle("Search")
    }
}
