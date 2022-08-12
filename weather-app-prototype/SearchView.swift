//
//  SearchView.swift
//  weather-app
//
//  Created by Niranjan Bukkapatna on 7/31/22.
//

import SwiftUI

struct SearchView: View {
    @StateObject var forecastListVM = ForecastListViewModel()
    @State var isSheet: Bool = false
    var cities = loadCSV(from: "us_cities")
    var filtered: [City] {
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

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}

//TextField("Enter a location", text: $forecastListVM.location)
//    .textFieldStyle(RoundedBorderTextFieldStyle())
//    .padding(.horizontal, 20)
//Button {
//    forecastListVM.fetchData()
//} label: {
//    Image(systemName: "magnifyingglass.circle.fill")
//        .font(.title3)
//}
//.padding(30)
//}
//}
