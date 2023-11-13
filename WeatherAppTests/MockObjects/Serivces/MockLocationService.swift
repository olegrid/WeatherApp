//
//  MockLocationService.swift
//  WeatherAppTests
//
//  Created by Aleh on 12/11/2023.
//

import Foundation
import MapKit
@testable import WeatherApp

class MockLocationService: LocationServiceProtocol {
    
    let mockIsLocationServiceEnable = true
    var spyIsLocationServiceEnableCalled = false
    func isLocationServiceEnable() -> Bool {
        spyIsLocationServiceEnableCalled = true
        return mockIsLocationServiceEnable
    }
    
    var spyIsStartUpdateLocationCalled = false
    func startUpdateLocation() {
        spyIsStartUpdateLocationCalled = true
    }
    
    var mockCurrentLocation: CLLocationCoordinate2D? = nil
    var spyIsGetCurrentLocationCalled = false
    func getCurrentLocation() -> CLLocationCoordinate2D? {
        spyIsGetCurrentLocationCalled = true
        return mockCurrentLocation
    }
    
    var spyIsSetDelegateCalled = false
    var spyDelegate: WeatherApp.LocationServiceDelegate? = nil
    func setDelegate(delegate: WeatherApp.LocationServiceDelegate) {
        spyIsSetDelegateCalled = true
        spyDelegate = delegate
    }
    
    
}
