//
//  Weather.swift
//  WeatherApp
//
//  Created by Aleh on 08/11/2023.
//

import Foundation

struct Weather {
    let temperture: Double
    
    static func initWith(dictionary: [String: Any]) -> Weather? {
        guard let dict = dictionary["main"] as? [String: Any] else {
            return nil
        }
        guard let temp = dict["temp"] as? Double else {
            return nil
        }
        
        return Weather(temperture: temp)
    }
}
