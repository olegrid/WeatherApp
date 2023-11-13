//
//  ServicesProvider.swift
//  WeatherApp
//
//  Created by Aleh on 10/11/2023.
//

import Foundation

protocol ServicesProviderProtocol {
    func getURLService() -> URLServiceProtocol
    func getNetworkService() -> NetworkServiceProtocol
    func getLocationService() -> LocationServiceProtocol
    func getStorageService() -> StorageServiceProtocol
    func getSettingsService() -> SettingsServiceProtocol
}

struct ServicesProvider: ServicesProviderProtocol {
    private let urlService: URLServiceProtocol
    private let networkService: NetworkServiceProtocol
    private let locationService: LocationServiceProtocol
    private let storageService: StorageServiceProtocol
    private let settingsService: SettingsServiceProtocol
    
    init() {
        urlService = URLService()
        networkService = NetworkService(urlService: urlService)
        locationService = LocationService()
        storageService = StorageService()
        settingsService = SettingsService(storageService: storageService)
    }
    
    func getURLService() -> URLServiceProtocol {
        return urlService
    }
    
    func getNetworkService() -> NetworkServiceProtocol {
        return networkService
    }
    
    func getLocationService() -> LocationServiceProtocol {
        return locationService
    }
    
    func getStorageService() -> StorageServiceProtocol {
        return storageService
    }
    
    func getSettingsService() -> SettingsServiceProtocol {
        return settingsService
    }
    
}
