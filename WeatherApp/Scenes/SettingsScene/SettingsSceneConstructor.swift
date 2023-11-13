//
//  SettingsSceneConstructor.swift
//  WeatherApp
//
//  Created by Aleh on 10/11/2023.
//

import Foundation
import UIKit

protocol SettingsSceneConstructorProtocol {
    static func createScene(serviceProvider: ServicesProviderProtocol) -> UIViewController
}

final class SettingsSceneConstructor: SettingsSceneConstructorProtocol {
    
    static func createScene(serviceProvider: ServicesProviderProtocol) -> UIViewController {
        let controller = SettingsSceneView(nibName: "SettingsSceneView", bundle: nil)
        let presenter = SettingsScenePresenter()
        controller.setupWithPreseter(presenter)
        
        
        let networkService = serviceProvider.getNetworkService()
        let settingsService = serviceProvider.getSettingsService()
        
        presenter.setupWithView(view: controller,
                                networkService: networkService,
                                settingsService: settingsService)
        return controller
    }
    
}
