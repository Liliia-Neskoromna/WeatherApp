//
//  WeatherItem.swift
//  WeatherApp
//
//  Created by Lilia on 7/8/20.
//  Copyright © 2020 Lilia. All rights reserved.
//

import Foundation
import UIKit

struct WeatherItem: Decodable, Hashable {
    
    var dt: Int64
    var temp: Float
    var pressure: Int32
    var humidity: Int
    var wind_speed: Float
    
}
