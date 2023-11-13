//
//  NetworkService.swift
//  WeatherApp
//
//  Created by Aleh on 08/11/2023.
//

import Foundation
import CoreLocation

protocol NetworkServiceProtocol {
    func getWeatherData(lat: Double, lon: Double, units: MeasurementT, completionHandler: @escaping (Weather?, Error?) -> Void)
    func searchLocationsByName(name: String, completionHandler: @escaping ([Location]?, Error?) -> Void)
}

final class NetworkService: NetworkServiceProtocol {
    
    private let urlService: URLServiceProtocol
    
    init(urlService: URLServiceProtocol) {
        self.urlService = urlService
    }
    
    private func createURLRequestForURL(url: URL) -> URLRequest{
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.timeoutInterval = 5
        return request
    }
    
    private func parsingDataAsDictionary(_ data: Data?) -> [String: Any]? {
        guard let data = data else {
            return nil
        }
        do {
            let result = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            return result
        } catch {
            return nil
        }
    }
    
    private func parsingDataAsArray(_ data: Data?) -> [[String: Any]]? {
        guard let data = data else {
            return nil
        }
        do {
            let result = try JSONSerialization.jsonObject(with: data, options: []) as? [[String: Any]]
            return result
        } catch {
            return nil
        }
    }
    
    func getWeatherData(lat: Double, lon: Double, units: MeasurementT, completionHandler: @escaping (Weather?, Error?) -> Void) {
        guard let url = urlService.getURLForWhetherData(lat: lat, lon: lon, units: units) else {
            completionHandler(nil, nil)
            return
        }
        
        let request = createURLRequestForURL(url: url)
        let task = URLSession.shared.dataTask(with: request) { [weak self] data, responce, error in
            guard let self = self else {
                return
            }
            
            if error == nil,
               let dict = self.parsingDataAsDictionary(data),
               let weather = Weather.initWith(dictionary: dict) {
                completionHandler(weather, nil)
                return
            }
            completionHandler(nil, error)
        }
        
        task.resume()
        
    }
    
    func searchLocationsByName(name: String, completionHandler: @escaping ([Location]?, Error?) -> Void) {
        guard let url = urlService.getURLForSearchLocations(name: name) else {
            completionHandler(nil, nil)
            return
        }
        
        let request = createURLRequestForURL(url: url)
        let task = URLSession.shared.dataTask(with: request) { [weak self] data, responce, error in
            guard let self = self else {
                return
            }
            
            var result = [Location]()
            if error == nil, let array = self.parsingDataAsArray(data) {
                for dict in array {
                    if let location = Location.initWithDictioary(dict) {
                        result.append(location)
                    }
                }
            }
            completionHandler(result, error)
        }
        
        task.resume()
    }
}
