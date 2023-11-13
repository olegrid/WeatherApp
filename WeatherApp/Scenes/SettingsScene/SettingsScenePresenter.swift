//
//  SettingsScenePresenter.swift
//  WeatherApp
//
//  Created by Aleh on 10/11/2023.
//

import Foundation

protocol SettingsScenePresenterProtocol {
    func setupWithView(view: SettingsSceneViewProtocol,
                       networkService: NetworkServiceProtocol?,
                       settingsService: SettingsServiceProtocol?
    )
    
    func searchLocationsByName(_ name: String)
    func didSelectLocation(_ location: Location)
}

class SettingsScenePresenter: SettingsScenePresenterProtocol {
    
    private weak var view: SettingsSceneViewProtocol?
    private var networkService: NetworkServiceProtocol?
    private var settingsService: SettingsServiceProtocol?
    private var timer: Timer?
    
    func setupWithView(view: SettingsSceneViewProtocol,
                       networkService: NetworkServiceProtocol?,
                       settingsService: SettingsServiceProtocol?
    ) {
        self.view = view
        self.networkService = networkService
        self.settingsService = settingsService
    }
    
    func searchLocationsByName(_ name: String) {
        timer?.invalidate()

        if !name.isEmpty {
            timer = Timer.scheduledTimer(withTimeInterval: 0.8, repeats: false, block: { [weak self] _ in
                self?.startSearch(name: name)
            })
        } else {
            self.view?.showSearchResults(searchResult: [Location](), errorText: nil)
        }
        
    }
    
    func didSelectLocation(_ location: Location) {
        settingsService?.setSelectedLocation(location: location)
        settingsService?.setPreferableLocationSetting(.selectedLocation)
        view?.dismissScene()
    }
    
    private func startSearch(name: String) {
        networkService?.searchLocationsByName(name: name, completionHandler: { [weak self] locations, error in
            let errorText = error?.localizedDescription ?? nil
            DispatchQueue.main.async {
                self?.view?.showSearchResults(searchResult: locations, errorText: errorText)
            }
        })
    }
    
}
