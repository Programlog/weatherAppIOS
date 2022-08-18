//
//  SearchView.swift
//  weather-app
//
//  Created by Niranjan Bukkapatna on 7/31/22.
//

import SwiftUI

struct SearchView: View {
    @EnvironmentObject var forecastListVM: ForecastListViewModel
    @State private var textForm: String = "Princeton"
    @State private var isSheet: Bool = false
    private let cities = loadCSV(from: "us_cities")
    private var filtered: [City] {
        if textForm.isEmpty {return cities}
        return cities.filter {
            $0.CITY.localizedCaseInsensitiveContains(textForm)
        }
    }

    var body: some View {
//        NavigationView {
//            List(filtered, id:\.self) { city in
////                NavigationLink(isActive: Binding<Bool>(get: {isSheet}, set: {isSheet = $0; forecastListVM.fetchData(lat: Double(city.LATITUDE)!, lon: Double(city.LONGITUDE)!)})) {
////                    HomeView2()
////                } label: {
////                    Text("\(city.CITY), \(city.STATE_CODE)")
////                }
//                NavigationLink {
//                    HomeView2()
//                        .onAppear {
//                            forecastListVM.fetchData(lat: Double(city.LATITUDE)!, lon: Double(city.LONGITUDE)!)
//                        }
//                } label: {
//                    Text("\(city.CITY), \(city.STATE_CODE)")
//                }
//            }
//            .searchable(text: $textForm, placement: .navigationBarDrawer(displayMode: .always), prompt: "Enter a city") {
//                if filtered.isEmpty {
//                    let randomCity = cities.randomElement()
//                    Text("Maybe you are looking for \(randomCity?.CITY ?? "Princeton"), \(randomCity?.STATE_CODE ?? "NJ")")
//                        .searchCompletion("\(randomCity?.CITY ?? "Princeton"), \(randomCity?.STATE_CODE ?? "NJ")")
//                }
//            }
//            .navigationTitle("Search")
//
////            .id(UUID().uuidString)
//        }
//        .navigationViewStyle(.stack)
        
        NavigationView {
            List {
                ForEach(filtered, id:\.self) { city in
                    NavigationLink {
                        HomeView2()
                            .onAppear {
                                forecastListVM.fetchData(lat: Double(city.LATITUDE)!, lon: Double(city.LONGITUDE)!)
                            }
                    } label: {
                        Text("\(city.CITY), \(city.STATE_CODE)")
                    }
                }
            }
            .id(UUID())
            .searchable(text: $textForm, placement: .navigationBarDrawer(displayMode: .always), prompt: "Enter a city") {
                if filtered.isEmpty {
                    let randomCity = cities.randomElement()
                    Text("Maybe you are looking for \(randomCity?.CITY ?? "Princeton"), \(randomCity?.STATE_CODE ?? "NJ")")
                        .searchCompletion("\(randomCity?.CITY ?? "Princeton"), \(randomCity?.STATE_CODE ?? "NJ")")
                }
            }
            .navigationTitle("Search")
        }

    }
}
