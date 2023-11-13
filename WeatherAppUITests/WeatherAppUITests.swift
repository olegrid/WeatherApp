//
//  WeatherAppUITests.swift
//  WeatherAppUITests
//
//  Created by Aleh on 08/11/2023.
//

import XCTest

final class WeatherAppUITests: XCTestCase {
    
    func testSearchLocation() {
        let app = XCUIApplication()
        app.launch()
        
        let button = app.buttons["Select Location"]
        button.tap()
        
        let searchBar = app.searchFields.firstMatch
        _ = searchBar.waitForExistence(timeout: 3)
        searchBar.tap()
        searchBar.typeText("Homyel")
        
        let cell = app.tables.element(boundBy: 0).cells.element(boundBy: 0)
        _ = cell.waitForExistence(timeout: 5)
        cell.tap()
        
        app.buttons[" F "].tap()
        app.buttons[" C "].tap()
        
    }
    
}
