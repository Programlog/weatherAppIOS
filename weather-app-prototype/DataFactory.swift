//
//  DataFactory.swift
//  weather-app-prototype
//
//  Created by Niranjan Bukkapatna on 8/11/22.
//

import Foundation
import SwiftUI

struct City: Identifiable, Hashable {
    var id = UUID()
    
    var ID: String = "0"
    var STATE_CODE: String = "NJ"
    var STATE_NAME: String = "New Jersey"
    var CITY: String = "Princeton"
    var LATITUDE: String = "40"
    var LONGITUDE: String = "-74"
    
    init(raw: [String]) {
        self.ID = raw[0]
        self.STATE_CODE = raw[1]
        self.STATE_NAME = raw[2]
        self.CITY = raw[3]
        self.LATITUDE = raw[5]
        self.LONGITUDE = raw[6]
    }
}

func loadCSV(from csvName: String) -> [City] {
    var csvToStruct = [City]()
    
    guard let filePath = Bundle.main.path(forResource: csvName, ofType: "csv") else {
        return []
    }
    
    var data = ""
    do {
        data = try String(contentsOf: URL(fileURLWithPath: filePath))
    } catch {
        print(error.localizedDescription)
        return []
    }
    var rows = data.components(separatedBy: "\n")
    
    
    let columnCount = rows.first?.components(separatedBy: ",").count
    rows.removeFirst()
    
    for row in rows {
        let csvColumns = row.components(separatedBy: ",")
        if columnCount == csvColumns.count {
            let cityStruct = City.init(raw: csvColumns)
            csvToStruct.append(cityStruct)
        }
    }
    
    return deleteDuplicates(oldCities: csvToStruct)
    
}

func deleteDuplicates(oldCities: [City]) -> [City]{
    var cities = oldCities
    let removeCharacters: Set<Character> = ["\""]
    var i = 1
    while i < cities.count {
        if cities[i].CITY == cities[i-1].CITY && cities[i].STATE_NAME == cities[i-1].STATE_NAME {
            cities.remove(at: i-1)
            cities[i].CITY = cities[i].CITY.replacingOccurrences(of: "\"", with: "", options: NSString.CompareOptions.literal, range:nil)

        }
        if cities[i].CITY.range(of:"\"") != nil {
                cities[i].CITY.removeAll(where: { removeCharacters.contains($0) } )
        }
        i += 1
    }
    return cities
}


