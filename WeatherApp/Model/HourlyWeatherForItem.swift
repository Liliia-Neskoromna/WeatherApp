//
//  HourlyWeatherForItem.swift
//  WeatherApp
//
//  Created by Lilia on 7/6/20.
//  Copyright © 2020 Lilia. All rights reserved.
//

import Foundation
import UIKit

struct HourlyWeatherForItem: HourlyWeatherDecodable, Hashable {
    var dt: Int64
    var temp: Temperature
    var pressure: Int32
    var humidity: Int
    var wind_speed: Float
    var weather: [HoWeather]
}

struct Temperature: Decodable, Hashable {
    var day: Float
    var night: Float
}

struct HoWeather: Decodable, Hashable {
    var main: String
    var icon: String
}


