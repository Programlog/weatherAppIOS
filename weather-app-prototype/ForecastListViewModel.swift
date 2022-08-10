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
    struct AppError: Identifiable {
        let id = UUID().uuidString
        let errorString: String
    }
    @Published var forecasts: ForecastViewModel?
    @Published var appError: AppError? = nil
//    var appError: AppError? = nil

    @Published var isLoading: Bool = false
    @AppStorage("location") var storageLocation: String = "Princeton"
    @Published var location = ""
    @AppStorage("system") var system: Int = 0 {
        didSet {
            forecasts?.system = system
        }
    }
    
    init() {
        location = storageLocation
        if location == "" {
            location = "Princeton"
        }
        if location != "" {
            fetchData()
        }
    }
    
    func fetchData() {
//        storageLocation = location
        isLoading = true
        let apiService = APIService.shared
        CLGeocoder().geocodeAddressString(location) { (placemarks, error) in
            if let error = error as? CLError {
                switch error.code {
                case .locationUnknown, .geocodeFoundNoResult, .geocodeFoundPartialResult:
                    self.appError = AppError(errorString: NSLocalizedString("Unable to determine location", comment: ""))
                case .network:
                    self.appError = AppError(errorString: NSLocalizedString("Couldn't acces network", comment: ""))
                @unknown default:
                    self.appError = AppError(errorString: error.localizedDescription)
                }
                self.isLoading = false
                self.location = "-----"
                print("line 33" + error.localizedDescription)
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
                        }

                    case .failure(let apiError):
                        switch apiError {
                        case .error(let errorString):
                            self.isLoading = false
                            self.appError = AppError(errorString: errorString)
                            print("line 51" + errorString)
                        }
                    }
                }
            }
        }
    }
}
