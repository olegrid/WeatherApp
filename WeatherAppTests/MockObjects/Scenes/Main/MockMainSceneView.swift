//
//  MockMainSceneView.swift
//  WeatherAppTests
//
//  Created by Aleh on 12/11/2023.
//

import Foundation
@testable import WeatherApp

class MockMainSceneView: MainSceneViewProtocol {
    
    var spyPresenter: WeatherApp.MainScenePresenterProtocol? = nil
    var spyIsSetupWithPreseterCalled = false
    func setupWithPreseter(_ presenter: WeatherApp.MainScenePresenterProtocol) {
        spyIsSetupWithPreseterCalled = true
        spyPresenter = presenter
    }
    
    var spyIsHidden: Bool? = nil
    var spySettings: WeatherApp.PreferableLocationSetting? = nil
    var spyIsSetupLocationSegmentedControlCalled = false
    func setupLocationSegmentedControl(isHidden: Bool, settings: WeatherApp.PreferableLocationSetting) {
        spyIsSetupLocationSegmentedControlCalled = true
        spyIsHidden = isHidden
        spySettings = settings
    }
    
    var spyMeasurment: WeatherApp.MeasurementT? = nil
    var isSetupMeasurmentSegmentControlCalled = false
    func setupMeasurmentSegmentControl(measurment: WeatherApp.MeasurementT) {
        isSetupMeasurmentSegmentControlCalled = true
        spyMeasurment = measurment
    }
    
    var spyLocationString: String? = nil
    var spyTempertureString: String? = nil
    var spyErrorString: String? = nil
    var spyIsShowDataInViewCalled = false
    func showDataInView(locationString: String?, tempertureString: String?, errorString: String?) {
        spyIsShowDataInViewCalled = true
        spyLocationString = locationString
        spyTempertureString = tempertureString
        spyErrorString = errorString
    }
    
    
}
