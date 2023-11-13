//
//  MockSettingsSceneView.swift
//  WeatherAppTests
//
//  Created by Aleh on 13/11/2023.
//

import Foundation
@testable import WeatherApp

class MockSettingsSceneView: SettingsSceneViewProtocol {
    
    var spyIsSetupWithPreseterCalled: Bool? = nil
    func setupWithPreseter(_ presenter: WeatherApp.SettingsScenePresenterProtocol) {
        spyIsSetupWithPreseterCalled = true
    }
    
    var spyIsShowSearchResultsCalled: Bool? = nil
    var spySearchResult: [WeatherApp.Location]? = nil
    var spyErrorText: String? = nil
    func showSearchResults(searchResult: [WeatherApp.Location]?, errorText: String?) {
        spyIsShowSearchResultsCalled = true
        spySearchResult = searchResult
        spyErrorText = errorText
    }
    
    var spyIsDismissSceneCalled: Bool? = nil
    func dismissScene() {
        spyIsDismissSceneCalled = true
    }
    
    
}
