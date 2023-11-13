//
//  MainSceneTests.swift
//  WeatherAppTests
//
//  Created by Aleh on 12/11/2023.
//

import Foundation

import XCTest
@testable import WeatherApp
import CoreLocation

final class MainSceneTests: XCTestCase {
    
    var presenter: MainScenePresenter?
    
    var mockView: MockMainSceneView?
    var mockNetworkService: MockNetworkService?
    var mockLocationService: MockLocationService?
    var mockSettingsService: MockSettingsService?
    var mockRouter: MockRouter?
    
    override func setUp() {
        super.setUp()
        mockView = MockMainSceneView()
        mockNetworkService = MockNetworkService()
        mockLocationService = MockLocationService()
        mockSettingsService = MockSettingsService()
        mockRouter = MockRouter()
        
        presenter = MainScenePresenter(
            view: mockView!,
            networkService: mockNetworkService!,
            locationService: mockLocationService!,
            settingsService: mockSettingsService!,
            router: mockRouter!)
    }
    
    func testSelectedLocation() {
        let weather = Weather(temperture: 10)
        let location = Location(name: "Name", state: "State", country: "Country", lat: 10, lon: 20)
        mockNetworkService?.mockWeather = weather
        mockSettingsService?.mockPreferableLocationSetting = .selectedLocation
        mockSettingsService?.mockSelectedMeasurment = .MeasurementF
        mockSettingsService?.mockSelectedLocation = location
        
        presenter?.viewReadyForData()
        
        let exp1 = expectation(description: "exp")
        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
            exp1.fulfill()
        })
        waitForExpectations(timeout: 2, handler: nil)
        
        XCTAssert(mockView?.isSetupMeasurmentSegmentControlCalled == true)
        XCTAssert(mockView?.spyMeasurment == .MeasurementF)
        XCTAssert(mockView?.spyIsShowDataInViewCalled == true)
        XCTAssert(mockView?.spyLocationString == location.name)
        XCTAssert(mockView?.spyTempertureString == "10 F")
        XCTAssert(mockView?.spyErrorString == nil)
        
        
        mockView?.spyIsShowDataInViewCalled = false
        mockSettingsService?.mockSelectedMeasurment = .MeasurementC
        presenter?.changeSelectedMeasurment(measurment: .MeasurementC)
        let exp2 = expectation(description: "exp")
        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
            exp2.fulfill()
        })
        waitForExpectations(timeout: 2, handler: nil)
        XCTAssert(mockView?.spyIsShowDataInViewCalled == true)
        XCTAssert(mockView?.spyLocationString == location.name)
        XCTAssert(mockView?.spyTempertureString == "10 C")
        XCTAssert(mockView?.spyErrorString == nil)
        XCTAssert(mockSettingsService?.spyIsSetSelectedMeasurmentCalled == true)
        
    }
    
    func testCurrentLocation() {
        let weather = Weather(temperture: 20)
        let location = Location(name: "Name", state: "State", country: "Country", lat: 20, lon: 20)
        mockLocationService?.mockCurrentLocation = CLLocationCoordinate2D(latitude: 20, longitude: 20)
        mockSettingsService?.mockPreferableLocationSetting = .currentLocation
        mockSettingsService?.mockSelectedMeasurment = .MeasurementF
        mockSettingsService?.mockSelectedLocation = location
        mockNetworkService?.mockWeather = weather
        mockNetworkService?.mockLocations = [location]
        
        presenter?.viewReadyForData()
        
        let exp = expectation(description: "exp")
        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
            exp.fulfill()
        })
        waitForExpectations(timeout: 2, handler: nil)
        
        XCTAssert(mockView?.isSetupMeasurmentSegmentControlCalled == true)
        XCTAssert(mockView?.spyMeasurment == .MeasurementF)
        XCTAssert(mockView?.spyIsShowDataInViewCalled == true)
        XCTAssert(mockView?.spyLocationString == "Current location")
        XCTAssert(mockView?.spyTempertureString == "20 F")
        XCTAssert(mockView?.spyErrorString == nil)
        
        mockView?.spyIsShowDataInViewCalled = false
        mockSettingsService?.mockSelectedMeasurment = .MeasurementC
        presenter?.changeSelectedMeasurment(measurment: .MeasurementC)
        let exp2 = expectation(description: "exp")
        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
            exp2.fulfill()
        })
        waitForExpectations(timeout: 2, handler: nil)
        XCTAssert(mockView?.spyIsShowDataInViewCalled == true)
        XCTAssert(mockView?.spyLocationString == "Current location")
        XCTAssert(mockView?.spyTempertureString == "20 C")
        XCTAssert(mockView?.spyErrorString == nil)
        XCTAssert(mockSettingsService?.spyIsSetSelectedMeasurmentCalled == true)
    }
    
    func testSwitchLocation() {
        let weather = Weather(temperture: 20)
        let location = Location(name: "Name", state: "State", country: "Country", lat: 20, lon: 20)
        mockLocationService?.mockCurrentLocation = CLLocationCoordinate2D(latitude: 20, longitude: 20)
        mockSettingsService?.mockSelectedLocation = location
        mockSettingsService?.mockPreferableLocationSetting = .currentLocation
        mockSettingsService?.mockSelectedMeasurment = .MeasurementF
        mockSettingsService?.mockSelectedLocation = location
        mockNetworkService?.mockWeather = weather
        mockNetworkService?.mockLocations = [location]
        
        presenter?.viewReadyForData()
        
        let exp = expectation(description: "exp")
        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
            exp.fulfill()
        })
        waitForExpectations(timeout: 2, handler: nil)
        
        XCTAssert(mockView?.isSetupMeasurmentSegmentControlCalled == true)
        XCTAssert(mockView?.spyMeasurment == .MeasurementF)
        XCTAssert(mockView?.spyIsShowDataInViewCalled == true)
        XCTAssert(mockView?.spyLocationString == "Current location")
        XCTAssert(mockView?.spyTempertureString == "20 F")
        XCTAssert(mockView?.spyErrorString == nil)
        
        mockView?.spyIsShowDataInViewCalled = false
        mockSettingsService?.mockSelectedMeasurment = .MeasurementC
        mockSettingsService?.mockPreferableLocationSetting = .selectedLocation
        presenter?.changeSelectedLocationType(setting: .selectedLocation)
        let exp2 = expectation(description: "exp")
        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
            exp2.fulfill()
        })
        waitForExpectations(timeout: 2, handler: nil)
        XCTAssert(mockView?.spyIsShowDataInViewCalled == true)
        XCTAssert(mockView?.spyLocationString == location.name)
        XCTAssert(mockView?.spyTempertureString == "20 C")
        XCTAssert(mockView?.spyErrorString == nil)
        XCTAssert(mockSettingsService?.isSetPreferableLocationSettingCalled == true)
    }
    
    func testSettingsScene() {
        let weather = Weather(temperture: 20)
        let location = Location(name: "Name", state: "State", country: "Country", lat: 20, lon: 20)
        mockLocationService?.mockCurrentLocation = CLLocationCoordinate2D(latitude: 20, longitude: 20)
        mockSettingsService?.mockSelectedLocation = location
        mockSettingsService?.mockPreferableLocationSetting = .currentLocation
        mockSettingsService?.mockSelectedMeasurment = .MeasurementF
        mockSettingsService?.mockSelectedLocation = location
        mockNetworkService?.mockWeather = weather
        mockNetworkService?.mockLocations = [location]
        
        presenter?.selectLocation()
        
        XCTAssert(mockRouter?.spyIsShowSettingsSceneCalled == true)
    }
    
    
}
