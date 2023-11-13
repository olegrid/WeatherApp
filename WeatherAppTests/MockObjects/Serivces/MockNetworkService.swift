//
//  MockNetworkService.swift
//  WeatherAppTests
//
//  Created by Aleh on 12/11/2023.
//

import Foundation
@testable import WeatherApp

class MockNetworkService: NetworkServiceProtocol {
    
    var mockWeather: Weather? = nil
    var mockWeatherError: Error? = nil
    
    var spyLat: Double? = nil
    var spyLon: Double? = nil
    var spyUnits: MeasurementT? = nil
    var spyIsGetWeatherDataCalled = false
    
    func getWeatherData(lat: Double, lon: Double, units: MeasurementT, completionHandler: @escaping (Weather?, Error?) -> Void) {
        spyIsGetWeatherDataCalled = true
        spyLat = lat
        spyLon = lon
        spyUnits = units
        completionHandler(mockWeather, mockWeatherError)
    }
    
    var mockLocations: [Location]? = nil
    var mockLocationError: Error? = nil
    
    var spyName: String? = nil
    var spyIsSearchLocationsByNameCalled = false
    func searchLocationsByName(name: String, completionHandler: @escaping ([Location]?, Error?) -> Void) {
        spyIsSearchLocationsByNameCalled = true
        spyName = name
        completionHandler(mockLocations, mockLocationError)
    }
}
