//
//  SettingsService.swift
//  WeatherApp
//
//  Created by Aleh on 09/11/2023.
//

import Foundation

enum PreferableLocationSetting: String {
    case selectedLocation = "selectedLocation"
    case currentLocation = "currentLocation"
    case unselected = "unselected"
}

protocol SettingsServiceProtocol {
    func getSelectedMeasurment() -> MeasurementT
    func setSelectedMeasurment(_ measurment: MeasurementT)
    
    func getSelectedLocation() -> Location?
    func setSelectedLocation(location: Location)
    
    func getPreferableLocationSetting() -> PreferableLocationSetting
    func setPreferableLocationSetting(_ setting: PreferableLocationSetting)
    
}

class SettingsService: SettingsServiceProtocol {
    
    let storageService: StorageServiceProtocol
    
    var selectedMeasurement: MeasurementT
    var preferableLocationSetting : PreferableLocationSetting
    
    init(storageService: StorageServiceProtocol) {
        self.selectedMeasurement = storageService.getSelectedMeasurment()
        self.storageService = storageService
        self.preferableLocationSetting = storageService.getPreferableLocationSetting()
    }
    
    func getSelectedMeasurment() -> MeasurementT {
        return selectedMeasurement
    }
    
    func setSelectedMeasurment(_ measurment: MeasurementT) {
        selectedMeasurement = measurment
        storageService.saveSelectedMeasurment(measurment)
    }
    
    func getSelectedLocation() -> Location? {
        return storageService.getSelectedLocation()
    }
    
    func setSelectedLocation(location: Location) {
        storageService.saveSelectedLocation(location)
    }
    
    func getPreferableLocationSetting() -> PreferableLocationSetting {
        return preferableLocationSetting
    }
    
    func setPreferableLocationSetting(_ setting: PreferableLocationSetting) {
        preferableLocationSetting = setting
        storageService.savePreferableLocationSetting(setting)
    }
    
}
