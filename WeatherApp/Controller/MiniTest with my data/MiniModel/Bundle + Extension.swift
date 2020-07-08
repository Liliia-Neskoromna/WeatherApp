//
//  Bundle + Extension.swift
//  WeatherApp
//
//  Created by Lilia on 7/8/20.
//  Copyright © 2020 Lilia. All rights reserved.
//

import Foundation
import UIKit

//extension Bundle {
//    func decode<T: Decodable>(_ type: T.Type, from filename: String) -> T {
//        guard let json = url(forResource: filename, withExtension: nil) else {
//            fatalError("Failed to locate \(filename) in app bundle.")
//        }
//
//        guard let jsonData = try? Data(contentsOf: json) else {
//            fatalError("Failed to load \(filename) from app bundle.")
//        }
//
//        let decoder = JSONDecoder()
//
//        guard let result = try? decoder.decode(T.self, from: jsonData) else {
//            fatalError("Failed to decode \(filename) from app bundle.")
//        }
//
//        return result
//    }
//}

extension Bundle {
    func decode<T: Decodable>(_ type: T.Type, from file: String) -> T {
        guard let url = url(forResource: file, withExtension: nil) else {
            fatalError("Failed to locate \(file) in bundle.")
        }

        guard let data = try? Data(contentsOf: url) else {
            fatalError("Failed to load \(file) from bundle.")
        }

        let decoder = JSONDecoder()

        guard let loaded = try? decoder.decode(T.self, from: data) else {
            fatalError("Failed to decode \(file) from bundle.")
        }

        return loaded
    }
}
