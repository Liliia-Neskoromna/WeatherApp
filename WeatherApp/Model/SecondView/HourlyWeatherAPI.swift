//
//  HourlyWeather.swift
//  WeatherApp
//
//  Created by Lilia on 7/6/20.
//  Copyright © 2020 Lilia. All rights reserved.
//

import Foundation
import UIKit

struct HourlyWeatherAPI: Decodable, Hashable {
    var dt: Int64
    var temp: Float
    var pressure: Int32
    var humidity: Int
    var wind_speed: Float
    var weather: [HWeather]
    
    func mapTo(_: HourlyWeatherAPI) -> AppHourly  {
        
        let initialStruct = [HourlyWeatherAPI]()
        var endStruct = [AppHourly]()
        
        for initial in initialStruct {
            let dt = initial.dt
            let nigth = 0
            let temp = HTemperature(day: initial.temp, night: nigth)
            let pressure = initial.pressure
            let humidity = initial.humidity
            let wind_speed = initial.wind_speed
            let weather = initial.weather
            
            let yybh = AppHourly(
            let item: AppHourly = AppHourly
            (dt: dt,
                                                      temp: temp,
                                                      pressure: pressure,
                                                      humidity: humidity,
                                                      wind_speed: wind_speed,
                                                      weather: weather)
            arrayWeather.append(item)
            
        }
        return arrayWeather
    }
}

struct HWeather: Decodable, Hashable {
    var main: String
    var icon: String
}



