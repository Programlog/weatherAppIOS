//
//  SearchView.swift
//  weather-app
//
//  Created by Niranjan Bukkapatna on 7/31/22.
//

import SwiftUI

struct SearchView: View {
    @State private var searchTerm = ""
    @StateObject var forecastListVM = ForecastListViewModel()

    var body: some View {
        NavigationView {
            VStack{
                Text("Find a city")
                    .font(.title.weight(.bold))
                Text("Start searching for a city")
                    .multilineTextAlignment(.center)
                
                Button("Search") {
                    forecastListVM.fetchData()
                }
            }
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .foregroundColor(.gray)
            .navigationTitle("Search")

        }
        .searchable(text: forecastListVM.$location, prompt: "Enter a city...") {
//            Text("🍎").searchCompletion("apple")
//            Text("🍐").searchCompletion("Pear")
//            Text("🍌").searchCompletion("banana")
        }
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
