//
//  FileReader.swift
//  WeatherAppTests
//
//  Created by Aleh on 12/11/2023.
//

import Foundation

final class FileReader {
    
    static func readFile(name: String) -> String? {
        
        if let url =  Bundle(for: FileReader.self).url(forResource: name, withExtension: nil) {
            do {
                let contentOfFile = try String(contentsOf: url, encoding: .utf8)
                return contentOfFile
            }
            catch { }
        }
        return nil
    }
    
    static func getDictionaryFromFile(name: String) -> [String: Any] {
        if let contentOfFile = readFile(name: name),
           let data = contentOfFile.data(using: .utf8) {
            do {
                if let result = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                    return result
                }
            } catch { }
        }
         
        return [String: Any]()
    }
}
