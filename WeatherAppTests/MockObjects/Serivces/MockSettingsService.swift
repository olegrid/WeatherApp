//
//  MockSettingsService.swift
//  WeatherAppTests
//
//  Created by Aleh on 12/11/2023.
//

import Foundation
@testable import WeatherApp

class MockSettingsService: SettingsServiceProtocol {
    
    var mockSelectedMeasurment: WeatherApp.MeasurementT = .MeasurementC
    var spyIsGetSelectedMeasurmentCalled = false
    func getSelectedMeasurment() -> WeatherApp.MeasurementT {
        spyIsGetSelectedMeasurmentCalled = true
        return mockSelectedMeasurment
    }
    
    var spySetSelectedMeasurment: WeatherApp.MeasurementT? = nil
    var spyIsSetSelectedMeasurmentCalled = false
    func setSelectedMeasurment(_ measurment: WeatherApp.MeasurementT) {
        spyIsSetSelectedMeasurmentCalled = true
        spySetSelectedMeasurment = measurment
    }
    
    var mockSelectedLocation: WeatherApp.Location? = nil
    var spyIsGetSelectedLocationCalled = false
    func getSelectedLocation() -> WeatherApp.Location? {
        spyIsGetSelectedLocationCalled = true
        return mockSelectedLocation
    }
    
    var spySelectedLocation: WeatherApp.Location? = nil
    var spyIsSetSelectedLocationCalled = false
    func setSelectedLocation(location: WeatherApp.Location) {
        spyIsSetSelectedLocationCalled = true
        spySelectedLocation = location
    }
    
    var mockPreferableLocationSetting: WeatherApp.PreferableLocationSetting = .unselected
    var spyIsGetPreferableLocationSettingCalled = false
    func getPreferableLocationSetting() -> WeatherApp.PreferableLocationSetting {
        spyIsGetPreferableLocationSettingCalled = true
        return mockPreferableLocationSetting
    }
    
    var spyPreferableLocationSetting: WeatherApp.PreferableLocationSetting? = nil
    var isSetPreferableLocationSettingCalled = false
    func setPreferableLocationSetting(_ setting: WeatherApp.PreferableLocationSetting) {
        isSetPreferableLocationSettingCalled = true
        spyPreferableLocationSetting = setting
    }
    
    
}
