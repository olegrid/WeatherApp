//
//  LocationParserTests.swift
//  WeatherAppTests
//
//  Created by Aleh on 12/11/2023.
//

import XCTest
@testable import WeatherApp

final class LocationObjectTest: XCTestCase {
    
    func testEmptyDictionary() {
        let input = [String: Any]()
        let location = Location.initWithDictioary(input)
        XCTAssertTrue(location == nil)
    }
    
    func testCorrectDictionary() {
        let correctDictionary = FileReader.getDictionaryFromFile(name: "CorrectLocationResponse.txt")
        if let location = Location.initWithDictioary(correctDictionary) {
            XCTAssertEqual(location.name, "Homyel")
            XCTAssertEqual(location.country, "BY")
            XCTAssertEqual(location.state, "Homyel Region")
            XCTAssertEqual(location.lat, 52.4238936)
            XCTAssertEqual(location.lon, 31.0131698)
        } else {
            XCTFail()
        }
    }
    
    func testNotCorrectDictionary() {
        let correctDictionary = FileReader.getDictionaryFromFile(name: "NotCorrectLocationResponse.txt")
        if let location = Location.initWithDictioary(correctDictionary) {
            XCTFail()
        } else {
            XCTAssertTrue(true)
        }
    }
    
}
