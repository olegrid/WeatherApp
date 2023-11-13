//
//  SettingsServiceTests.swift
//  WeatherAppTests
//
//  Created by Aleh on 12/11/2023.
//

import XCTest
@testable import WeatherApp

final class WeatherParserTests: XCTestCase {
    
    func testEmptyDictionary() {
        let input = [String: Any]()
        let location = Weather.initWith(dictionary: input)
        XCTAssertTrue(location == nil)
    }
    
    func testCorrectDictionary() {
        let correctDictionary = FileReader.getDictionaryFromFile(name: "CorrectWeatherResponse.txt")
        if let weather = Weather.initWith(dictionary: correctDictionary) {
            XCTAssertEqual(weather.temperture, 298.48)
        } else {
            XCTFail()
        }
    }
    
    func testNotCorrectDictionary1() {
        let correctDictionary = FileReader.getDictionaryFromFile(name: "NotCorrectWeatherResponse1.txt")
        if let weather = Weather.initWith(dictionary: correctDictionary) {
            XCTFail()
        } else {
            XCTAssertTrue(true)
        }
    }
    
    func testNotCorrectDictionary2() {
        let correctDictionary = FileReader.getDictionaryFromFile(name: "NotCorrectWeatherResponse2.txt")
        if let weather = Weather.initWith(dictionary: correctDictionary) {
            XCTFail()
        } else {
            XCTAssertTrue(true)
        }
    }
    
}

