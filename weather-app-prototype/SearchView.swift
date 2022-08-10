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

    var body: some View {
        NavigationView {
            VStack{
                Text("Find a city")
                    .font(.title.weight(.bold))
                Text("Start searching for a city")
                    .multilineTextAlignment(.center)
                
                Button("Search") {
                    forecastListVM.fetchData()
                    isSheet.toggle()
                }
            }
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .foregroundColor(.gray)
            .navigationTitle("Search")

        }
        .searchable(text: forecastListVM.$storageLocation, prompt: "Enter a city...") {
//            Text("🍎").searchCompletion("apple")
//            Text("🍐").searchCompletion("Pear")
//            Text("🍌").searchCompletion("banana")
        }
        .sheet(isPresented: $isSheet) {
            HomeView2()
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
