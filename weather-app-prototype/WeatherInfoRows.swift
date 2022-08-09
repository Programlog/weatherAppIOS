//
//  WeatherInfoRows.swift
//  weather-app-prototype
//
//  Created by Niranjan Bukkapatna on 8/8/22.
//

import SwiftUI

struct WeatherInfoRows: View {
    var systemImage: String
    var property: String
    var value: String
    var body: some View {
        HStack {
            Group {
                Image(systemName: systemImage)
                    .frame(width: 60, alignment: .center)
                    .shadow(color: Color("ColorBlackTransparentLight"), radius: 4, x: 0, y: 2)
                Text(property)
            }
            .foregroundColor(.blue)
            .font(Font.system(.body).bold())
            
            Spacer()
            Text(value)
                .multilineTextAlignment(.trailing)
                .padding(.horizontal, 20)

        }
    }
}

struct WeatherInfoRows_Previews: PreviewProvider {
    static var previews: some View {
        WeatherInfoRows(systemImage: "thermometer", property: "Temperature", value: "99°")
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
