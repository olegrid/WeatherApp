//
//  MainSceneConstructor.swift
//  WeatherApp
//
//  Created by Aleh on 08/11/2023.
//

import Foundation
import UIKit

protocol SceneConstructorProtocol {
    static func createScene(serviceProvider: ServicesProviderProtocol, router: RouterProtocol) -> UIViewController
}

final class MainSceneConstructor: SceneConstructorProtocol {
    
    static func createScene(serviceProvider: ServicesProviderProtocol, router: RouterProtocol) -> UIViewController {
        let controller = MainSceneView(nibName: "MainSceneView", bundle: nil)
        let presenter = MainScenePresenter.setupWithView(
            view: controller,
            networkService: serviceProvider.getNetworkService(),
            locationService: serviceProvider.getLocationService(),
            settingsService: serviceProvider.getSettingsService(),
            router: router
        )
        controller.setupWithPreseter(presenter)
        return controller
    }
    
}
