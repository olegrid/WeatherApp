//
//  MockRouter.swift
//  WeatherAppTests
//
//  Created by Aleh on 12/11/2023.
//

import Foundation
import UIKit
@testable import WeatherApp

class MockRouter: RouterProtocol {
    
    static func initWithWindow(window: UIWindow) -> WeatherApp.RouterProtocol {
        return MockRouter()
    }
    
    
    func showMainScene() {
        
    }
    
    var spyIsShowSettingsSceneCalled: Bool = false
    func showSettingsScene() {
        spyIsShowSettingsSceneCalled = true
    }
    
    
}
