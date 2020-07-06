//
//  DailyWeather.swift
//  WeatherApp
//
//  Created by Lilia on 7/6/20.
//  Copyright © 2020 Lilia. All rights reserved.
//

import Foundation
import UIKit

struct DailyWeather: Decodable, Hashable {
    var dt: Int64
    var temp: DTemperature
    var pressure: Int32
    var humidity: Int
    var wind_speed: Float
    var weather: [DWeather]
}

struct DTemperature: Decodable, Hashable {
    var day: Float
    var night: Float
}

struct DWeather: Decodable, Hashable {
    var main: String
    var icon: String
}
