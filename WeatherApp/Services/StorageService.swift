//
//  StorageService.swift
//  WeatherApp
//
//  Created by Aleh on 08/11/2023.
//

import Foundation

protocol StorageServiceProtocol {
    func getSelectedMeasurment() -> MeasurementT
    func saveSelectedMeasurment(_ measurment: MeasurementT)
    
    func getPreferableLocationSetting() -> PreferableLocationSetting
    func savePreferableLocationSetting(_ setting: PreferableLocationSetting)
    
    func getSelectedLocation() -> Location?
    func saveSelectedLocation(_ location: Location)
}

struct StorageService: StorageServiceProtocol {
    
    private let userDefaults = UserDefaults.standard
    private let measurementKey = "measurementKey"
    private let preferableLocationSettingKey = "preferableLocationSetting"
    private let selectedLocationKey = "selectedLocationKey"
    
    func getSelectedMeasurment() -> MeasurementT {
        let buf = userDefaults.value(forKey: measurementKey)
        if let measurementString = buf as? String, let measurement = MeasurementT(rawValue: measurementString) {
            return measurement
        } else {
            let defaultValue: MeasurementT = .MeasurementC
            saveSelectedMeasurment(defaultValue)
            return defaultValue
        }
    }
    
    func saveSelectedMeasurment(_ measurment: MeasurementT) {
        userDefaults.setValue(measurment.rawValue, forKey: measurementKey)
    }
    
    func getPreferableLocationSetting() -> PreferableLocationSetting {
        let buf = userDefaults.value(forKey: preferableLocationSettingKey)
        if let rawValue = buf as? String, let setting = PreferableLocationSetting(rawValue: rawValue) {
            return setting
        }
        return .unselected
    }
    
    func savePreferableLocationSetting(_ setting: PreferableLocationSetting) {
        userDefaults.setValue(setting.rawValue, forKey: preferableLocationSettingKey)
    }
    
    func getSelectedLocation() -> Location? {
        let data = userDefaults.object(forKey: selectedLocationKey)
        if let data = data, let data = data as? Data {
            let decoder = JSONDecoder()
            do {
                let location = try decoder.decode(Location.self, from: data)
                return location
            } catch {
                
            }
        }
        
        return nil
    }
    
    func saveSelectedLocation(_ location: Location) {
        let jsonEncoder = JSONEncoder()
        do {
            let data = try jsonEncoder.encode(location)
            userDefaults.setValue(data, forKey: selectedLocationKey)
        } catch {
            
        }
        
    }
    
}
