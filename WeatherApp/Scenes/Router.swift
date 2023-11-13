//
//  Router.swift
//  WeatherApp
//
//  Created by Aleh on 11/11/2023.
//

import Foundation
import UIKit

protocol RouterProtocol: AnyObject {
    static func initWithWindow(window: UIWindow) -> RouterProtocol
    
    func showMainScene()
    func showSettingsScene()
}

class Router: RouterProtocol {
    
    private let window: UIWindow
    private var navigationController: UINavigationController?
    
    private let servicesProvider = ServicesProvider()
    
    init(window: UIWindow) {
        self.window = window
    }
    
    static func initWithWindow(window: UIWindow) -> RouterProtocol {
        let router = Router(window: window)
        return router
    }
    
    func showMainScene() {
        let viewController = MainSceneConstructor.createScene(serviceProvider: servicesProvider, router: self)
        navigationController = UINavigationController(rootViewController: viewController)
        
        window.rootViewController = navigationController
    }
    
    func showSettingsScene() {
        let viewController = SettingsSceneConstructor.createScene(serviceProvider: servicesProvider)
        
        navigationController?.pushViewController(viewController, animated: true)
        
    }
}
