//
//  ContentView.swift
//  weather-app-prototype
//
//  Created by Varun K on 7/29/22.
//
import SwiftUI

struct ContentView: View {
    @StateObject var forecastListVM = ForecastListViewModel()
    
    var body: some View {
        if forecastListVM.isLoading {
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle(tint: .blue))
                .fullScreenCover(isPresented: $forecastListVM.isLoading, content: ProgressView.init)
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
                .font(.headline)
            
        }
//        ZStack {
//            NavigationView {
//                VStack {
//                    HStack {
//                        TextField("Enter a location", text: $forecastListVM.location)
//                            .textFieldStyle(RoundedBorderTextFieldStyle())
//                        Button {
//                            forecastListVM.fetchData()
//                        } label: {
//                            Image(systemName: "magnifyingglass.circle.fill")
//                                .font(.title3)
//                        }
//
//                    }
//                    VStack {
//                        Text("\(forecastListVM.forecasts?.day ?? "nil")")
//                        Text("\(forecastListVM.forecasts?.currentTemp ?? "nil temp")")
//                        Text("sunrise: \(forecastListVM.forecasts?.forecast.current.sunrise ?? -1)")
//                            .foregroundColor(.blue)
//                        Text("\(forecastListVM.forecasts?.forecast.lat ?? -1)")
//                        Image(systemName: forecastListVM.forecasts?.currentSystemImage ?? "sun.max.fill")
//                            .resizable()
//                            .scaledToFit()
//                            .frame(width: 100, alignment: .center)
//                    }
//                    Picker(selection: $forecastListVM.system, label: Text("Units")) {
//                        Text("Celsius").tag(0)
//                        Text("Fahrenheit").tag(1)
//                    }
//                    .pickerStyle(SegmentedPickerStyle())
//                    .frame(width: 200, height: 50, alignment: .center)
//                    .padding()
////                    List(forecastListVM.forecasts?.forecast.daily ?? nil, id: \.forecastListVM.forecasts?.forecast.daily.weather.id) { day in
////                            VStack(alignment:.leading) {
////                                Text(day.pop)
////                                    .fontWeight(.bold)
////                                HStack(alignment:.top) {
////                                    Image(systemName: "hourglass")
////                                        .font(.title)
////                                        .frame(width: 40, height: 40)
////                                        .background(RoundedRectangle(cornerRadius: 10).fill(.blue))
////                                    VStack(alignment:.leading) {
////                                        Text(day.dailyMain)
////                                        HStack {
////                                            Text("Temp: ")
////                                            Text("Max: \(day.temp.max)")
////                                            Text("Min: \(day.temp.min)")
////                                            Text("current Avg: \(day.currentTemp)")
////                                        }
////
//////                                        HStack {
//////                                            Text("Chance of rain: \(day.dailyPop)%")
//////                                            Text("Current Humidity: \(day.currentHumidity)%")
//////                                            Text("Sunrise: \(day.currentSunrise)")
//////                                        }
////
////                                    }
////                                }
////                            }
////                        }
////                        .listStyle(PlainListStyle())
//                }
//                .padding(.horizontal)
//                .navigationTitle("Weather app")
//
//            }
//        }
            
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

