//
//  URLService.swift
//  WeatherApp
//
//  Created by Aleh on 08/11/2023.
//

import Foundation
import CoreLocation

protocol URLServiceProtocol {
    func getURLForWhetherData(lat: Double, lon: Double, units: MeasurementT) -> URL?
    func getURLForSearchLocations(name: String) -> URL?
}

struct URLService: URLServiceProtocol {
    
    private enum urls: String {
        case whetherURL = "https://api.openweathermap.org/data/2.5/weather?lat=%f&lon=%f&appid=%@&units=%@"
        case locationsURL = "http://api.openweathermap.org/geo/1.0/direct?q=%@&limit=%d&appid=%@"
    }
        
    private func getAppID() -> String {
        return "9ffc56ec71d0b32f98a46f6c6656c60b"
    }
    
    func getURLForWhetherData(lat: Double, lon: Double, units: MeasurementT) -> URL? {
        let formatString = urls.whetherURL.rawValue
        let urlString = String(format: formatString, lat, lon, getAppID(), units.rawValue)
        return URL(string: urlString)
    }
    
    func getURLForSearchLocations(name: String) -> URL? {
        let formatString = urls.locationsURL.rawValue
        let urlString = String(format: formatString, name, 30, getAppID())
        return URL(string: urlString)
    }
    
}
