//
//  MainScenePresenter.swift
//  WeatherApp
//
//  Created by Aleh on 08/11/2023.
//

import Foundation
import CoreLocation

protocol MainScenePresenterProtocol {
    static func setupWithView(view: MainSceneViewProtocol,
                              networkService: NetworkServiceProtocol,
                              locationService: LocationServiceProtocol,
                              settingsService: SettingsServiceProtocol,
                              router: RouterProtocol
    ) -> MainScenePresenterProtocol
    
    func viewReadyForData()
    func changeSelectedLocationType(setting: PreferableLocationSetting)
    func changeSelectedMeasurment(measurment: MeasurementT)
    func selectLocation()
}

class MainScenePresenter: MainScenePresenterProtocol {
    
    private weak var view: MainSceneViewProtocol?
    private var networkService: NetworkServiceProtocol
    private var locationService: LocationServiceProtocol
    private var settingsService: SettingsServiceProtocol
    private weak var router: RouterProtocol?
    
    init(view: MainSceneViewProtocol, 
         networkService: NetworkServiceProtocol,
         locationService: LocationServiceProtocol,
         settingsService: SettingsServiceProtocol,
         router: RouterProtocol
    ) {
        self.view = view
        self.networkService = networkService
        self.locationService = locationService
        self.settingsService = settingsService
        self.router = router
        
        self.locationService.setDelegate(delegate: self)
    }
    
    static func setupWithView(
        view: MainSceneViewProtocol,
        networkService: NetworkServiceProtocol,
        locationService: LocationServiceProtocol,
        settingsService: SettingsServiceProtocol,
        router: RouterProtocol
    ) -> MainScenePresenterProtocol {
        
        return MainScenePresenter(
            view: view,
            networkService: networkService,
            locationService: locationService,
            settingsService: settingsService,
            router: router
        )
    }
    
    func viewReadyForData() {
        let preferedType = settingsService.getPreferableLocationSetting()
        if settingsService.getSelectedLocation() != nil, locationService.isLocationServiceEnable() {
            view?.setupLocationSegmentedControl(isHidden: false, settings: preferedType)
        } else {
            view?.setupLocationSegmentedControl(isHidden: true, settings: preferedType)
        }
        let measurment = settingsService.getSelectedMeasurment()
        view?.setupMeasurmentSegmentControl(measurment: measurment)
        
        switch preferedType {
        case .currentLocation:
            if let currentLocation = locationService.getCurrentLocation() {
                getWeatherByCoordinate2D(coodinate: currentLocation)
            } else {
                // error
            }
        case .selectedLocation:
            if let location = settingsService.getSelectedLocation() {
                getWeatherByLocation(location: location)
            }
        case.unselected:
            settingsService.setPreferableLocationSetting(.currentLocation)
            if locationService.isLocationServiceEnable() {
                if let currentLocation = locationService.getCurrentLocation() {
                    getWeatherByCoordinate2D(coodinate: currentLocation)
                } else {
                    // error
                }
            } else {
                
            }
        }
    }
    
    func changeSelectedLocationType(setting: PreferableLocationSetting) {
        settingsService.setPreferableLocationSetting(setting)
        viewReadyForData()
    }
    
    func changeSelectedMeasurment(measurment: MeasurementT) {
        settingsService.setSelectedMeasurment(measurment)
        viewReadyForData()
    }
    
    func selectLocation() {
        router?.showSettingsScene()
    }
    
    private func getWeatherByCoordinates(lat: Double, lon: Double) {
        let measurment = settingsService.getSelectedMeasurment()
        networkService.getWeatherData(
            lat: lat,
            lon: lon,
            units: measurment) { [weak self] weather, error in
                if let weather = weather {
                    self?.prepareDataForDisplay(weather: weather)
                }
            }
    }
    
    private func getWeatherByCoordinate2D(coodinate: CLLocationCoordinate2D) {
        getWeatherByCoordinates(lat: coodinate.latitude, lon: coodinate.longitude)
    }
    
    private func getWeatherByLocation(location: Location) {
        getWeatherByCoordinates(lat: location.lat, lon: location.lon)
    }
    
    private func prepareDataForDisplay(weather: Weather) {
        let locSettings = settingsService.getPreferableLocationSetting()
        let measurment = settingsService.getSelectedMeasurment()
        
        var locationString: String
        if locSettings == .selectedLocation  {
            let location = settingsService.getSelectedLocation()
            locationString = location?.name ?? ""
        } else {
            locationString = "Current location"
        }
        
        var tempertureString = String(format: "%.0f", round(weather.temperture))
        if measurment == .MeasurementC {
            tempertureString = tempertureString + " C"
        } else {
            tempertureString = tempertureString + " F"
        }
        
        DispatchQueue.main.async { [weak self] in
            self?.view?.showDataInView(locationString: locationString, tempertureString: tempertureString, errorString: nil)
        }
    }
    
}

extension MainScenePresenter: LocationServiceDelegate {
    
    func locationIsUpdated(coordinate: CLLocationCoordinate2D) {
        if settingsService.getPreferableLocationSetting() == .currentLocation {
            getWeatherByCoordinate2D(coodinate: coordinate)
        }
    }
    
}
