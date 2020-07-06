//
//  HourlyWeather.swift
//  WeatherApp
//
//  Created by Lilia on 7/6/20.
//  Copyright © 2020 Lilia. All rights reserved.
//

import Foundation
import UIKit

struct HourlyWeather: Decodable, Hashable {
    var dt: Int64
    var temp: Float
    var feels_like: Float
    var pressure: Int32
    var humidity: Int
    var wind_speed: Float
    var weather: [HWeather]
    
    //let weatherHourly =
}

struct HWeather: Decodable, Hashable {
    var main: String
    var icon: String
}



