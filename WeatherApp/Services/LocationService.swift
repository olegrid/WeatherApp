//
//  LocationService.swift
//  WeatherApp
//
//  Created by Aleh on 08/11/2023.
//

import Foundation
import MapKit

protocol LocationServiceProtocol {
    func isLocationServiceEnable() -> Bool
    func startUpdateLocation()
    func getCurrentLocation() -> CLLocationCoordinate2D?
    
    func setDelegate(delegate: LocationServiceDelegate)
}

protocol LocationServiceDelegate: AnyObject {
    func locationIsUpdated(coordinate: CLLocationCoordinate2D)
}

final class LocationService: NSObject, LocationServiceProtocol, CLLocationManagerDelegate {
    let locationManager = CLLocationManager()
    private weak var delegate: LocationServiceDelegate?
    
    override init() {
        super.init()
        locationManager.requestWhenInUseAuthorization()
        startUpdateLocation()
    }
    
    func setDelegate(delegate: LocationServiceDelegate) {
        self.delegate = delegate
    }
    
    func isLocationServiceEnable() -> Bool {
        return locationManager.authorizationStatus == CLAuthorizationStatus.authorizedWhenInUse
    }
    
    func startUpdateLocation() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyKilometer
        locationManager.startUpdatingLocation()
    }
    
    func getCurrentLocation() -> CLLocationCoordinate2D? {
        if isLocationServiceEnable() {
            let location = locationManager.location?.coordinate
            return location
        }
        return nil
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if !locations.isEmpty, let coordinate = locations.first?.coordinate {
            delegate?.locationIsUpdated(coordinate: coordinate)
        }
    }
}





