//
//  Json.swift
//  PodDesktop
//
//  Created by Luo Sheng on 2021/9/7.
//

import Foundation

func decode<T: Decodable>(_ type: T.Type, from data: Data) -> T {
    do {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    } catch {
        fatalError("Couldn't parse \(data) as \(T.self):\n\(error)")
    }
}

func decode<T: Decodable>(_ type: T.Type, from string: String) -> T {
    guard let data = string.data(using: .utf8) else {
        fatalError("Couldn't parse string into a valid JSON object \(string)")
    }
    return decode(T.self, from: data)
}

func loadMock<T: Decodable>(_ filename: String) -> T {
    let data: Data
    
    guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
    else {
        fatalError("Couldn't find \(filename) in main bundle.")
    }
    
    do {
        data = try Data(contentsOf: file)
    } catch {
        fatalError("Couldn't find \(filename) in main bundle.\n\(error)")
    }
    
    return decode(T.self, from: data)
}
