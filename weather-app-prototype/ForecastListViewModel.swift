//
//  ForecastListViewModel.swift
//  weather-app-prototype
//
//  Created by Varun K on 8/6/22.
//

import SwiftUI
import CoreLocation
import Foundation

class ForecastListViewModel: ObservableObject {
    @Published var forecasts: ForecastViewModel?
    @Published var isLoading: Bool = false
    @AppStorage("location") var location: String = ""
    @AppStorage("system") var system: Int = 0 {
        didSet {
            forecasts?.system = system
        }
    }
    
    init() {
        if location != "" {
            fetchData()
        }
    }
    
    func fetchData() {
        self.isLoading = true
        let apiService = APIService.shared
        CLGeocoder().geocodeAddressString(location) { (placemarks, error) in
            if let error = error {
                print(error.localizedDescription)
            }
            if let lat = placemarks?.first?.location?.coordinate.latitude,
               let lon = placemarks?.first?.location?.coordinate.longitude {
                apiService.getJSON(urlString: "https://api.openweathermap.org/data/2.5/onecall?lat=\(lat)&lon=\(lon)&exclude=minutely&appid=9c26eaf199aee244e3918d36243ffd97&units=imperial", dateDecodingStrategy: .secondsSince1970) { (result: Result<Forecast, APIService.APIError>) in
                    switch result {
                    case .success(let forecast):
                        DispatchQueue.main.async {
                            let to = ForecastViewModel(forecast: forecast, system: self.system)
                            self.forecasts = to
                            self.isLoading = false
                            //                            self.forecasts = forecast.current.map { ForecastViewModel(forecast: $0)}
//                            self.forecasts.append(contentsOf: forecast)
                        }

                    case .failure(let apiError):
                        switch apiError {
                        case .error(let errorString):
                            print(errorString)
                        }
                    }
                }
            }
        }
    }
}
