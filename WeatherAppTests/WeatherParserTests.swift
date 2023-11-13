//
//  WeatherParserTests.swift
//  WeatherAppTests
//
//  Created by Aleh on 12/11/2023.
//

import XCTest
@testable import WeatherApp

final class SettingsServiceTests: XCTestCase {
    
    func testMeasurement() {
        let storage = StorageService()
        let settingsService = SettingsService(storageService: storage)
        
        let mC = MeasurementT.MeasurementC
        settingsService.setSelectedMeasurment(mC)
        XCTAssertEqual(mC, settingsService.getSelectedMeasurment())
        
        let mF = MeasurementT.MeasurementF
        settingsService.setSelectedMeasurment(mF)
        XCTAssertEqual(mF, settingsService.getSelectedMeasurment())
    }
    
    func testSelectedLocation() {
        let storage = StorageService()
        let settingsService = SettingsService(storageService: storage)
        
        let location = Location(name: "Name", state: "State", country: "Country", lat: 10.10, lon: 1.01)
        settingsService.setSelectedLocation(location: location)
        if let savedLocation = settingsService.getSelectedLocation() {
            XCTAssertEqual(location.name, savedLocation.name)
            XCTAssertEqual(location.state, savedLocation.state)
            XCTAssertEqual(location.country, savedLocation.country)
            XCTAssertEqual(location.lat, savedLocation.lat)
            XCTAssertEqual(location.lon, savedLocation.lon)
        } else {
            XCTFail()
        }
    }
   
    func testPreferableLocationSetting() {
        let storage = StorageService()
        let settingsService = SettingsService(storageService: storage)
        
        let locationTypeCurrent = PreferableLocationSetting.currentLocation
        settingsService.setPreferableLocationSetting(locationTypeCurrent)
        var savedType = settingsService.getPreferableLocationSetting()
        XCTAssertEqual(locationTypeCurrent, savedType)
        
        let locationTypeSelected = PreferableLocationSetting.selectedLocation
        settingsService.setPreferableLocationSetting(locationTypeSelected)
        savedType = settingsService.getPreferableLocationSetting()
        XCTAssertEqual(locationTypeSelected, savedType)
        
        let locationTypeUnselecte = PreferableLocationSetting.unselected
        settingsService.setPreferableLocationSetting(locationTypeUnselecte)
        savedType = settingsService.getPreferableLocationSetting()
        XCTAssertEqual(locationTypeUnselecte, savedType)
    }
    
}
