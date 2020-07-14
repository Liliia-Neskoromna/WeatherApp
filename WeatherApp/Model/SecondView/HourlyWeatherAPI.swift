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
    
    
    func mapTo() -> AppHourly  {
        
        let dt = self.dt
        
        let night = 0
        let day = self.temp
        let temp = HTemperature(day: day, night: night)
        
        let pressure = self.pressure
        let humidity = self.humidity
        let wind_speed = self.wind_speed
        let weather = self.weather
        
        let item: AppHourly = AppHourly(dt: dt,
                                        temp: temp,
                                        pressure: pressure,
                                        humidity: humidity,
                                        wind_speed: wind_speed,
                                        weather: weather)
        return item
    }
    
    //    func mapTo(initialStruct: Array<HourlyWeatherAPI>) -> [AppHourly]  {
    //
    //        var endStruct: Array<AppHourly> = [AppHourly]()
    //
    //        for initial in initialStruct {
    //            let dt = initial.dt
    //            let nigth = 0
    //            let temp = HTemperature(day: initial.temp, night: nigth)
    //            let pressure = initial.pressure
    //            let humidity = initial.humidity
    //            let wind_speed = initial.wind_speed
    //            let weather = initial.weather
    //
    //            let item: AppHourly = AppHourly(dt: dt,
    //                                            temp: temp,
    //                                            pressure: pressure,
    //                                            humidity: humidity,
    //                                            wind_speed: wind_speed,
    //                                            weather: weather)
    //            endStruct.append(item)
    //        }
    //
    //        return endStruct
    //    }
}

struct HTemperature: Decodable, Hashable {
    var day: Float
    var night: Int?
}

struct HWeather: Decodable, Hashable {
    var main: String
    var icon: String
}
