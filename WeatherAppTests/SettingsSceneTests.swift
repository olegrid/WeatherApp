//
//  SettingsSceneTests.swift
//  WeatherAppTests
//
//  Created by Aleh on 13/11/2023.
//

import Foundation

import Foundation

import XCTest
@testable import WeatherApp
import CoreLocation

final class SettingsSceneTests: XCTestCase {
    
    var presenter: SettingsScenePresenter?
    
    var mockView: MockSettingsSceneView?
    var mockNetworkService: MockNetworkService?
    var mockSettingsService: MockSettingsService?
    var mockRouter: MockRouter?
    
    override func setUp() {
        super.setUp()
        mockView = MockSettingsSceneView()
        mockNetworkService = MockNetworkService()
        mockSettingsService = MockSettingsService()
        mockRouter = MockRouter()
        
        presenter = SettingsScenePresenter()
        presenter?.setupWithView(
            view: mockView!,
            networkService: mockNetworkService,
            settingsService: mockSettingsService
        )
    }
    
    func testSelectedLocation() {
        let location1 = Location(name: "Name1", state: "State", country: "Country", lat: 10, lon: 20)
        let location2 = Location(name: "Name2", state: "State", country: "Country", lat: 20, lon: 20)
        let location3 = Location(name: "Name3", state: "State", country: "Country", lat: 30, lon: 20)
        mockSettingsService?.mockPreferableLocationSetting = .selectedLocation
        mockSettingsService?.mockSelectedMeasurment = .MeasurementF
        let locationsArray = [location1, location2, location3]
        mockNetworkService?.mockLocations = locationsArray
        
        presenter?.searchLocationsByName("name")
        let exp1 = expectation(description: "exp")
        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
            exp1.fulfill()
        })
        waitForExpectations(timeout: 2, handler: nil)
        
        XCTAssert(mockNetworkService?.spyIsSearchLocationsByNameCalled == true)
        XCTAssert(mockNetworkService?.spyName == "name")
        XCTAssert(mockView?.spySearchResult?.count == locationsArray.count)
        
        presenter?.didSelectLocation(location1)
        let exp2 = expectation(description: "exp")
        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
            exp2.fulfill()
        })
        waitForExpectations(timeout: 2, handler: nil)
        
        XCTAssert(mockSettingsService?.spySelectedLocation?.name == location1.name)
        XCTAssert(mockSettingsService?.spyIsSetSelectedLocationCalled == true)
        XCTAssert(mockSettingsService?.isSetPreferableLocationSettingCalled == true)
        XCTAssert(mockSettingsService?.spyPreferableLocationSetting == .selectedLocation)
        XCTAssert(mockView?.spyIsDismissSceneCalled == true )
    }
}
